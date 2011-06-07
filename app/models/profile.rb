require 'net/http'


class Profile < ActiveRecord::Base
has_and_belongs_to_many :stations

cattr_reader :regions

@@region_def = {:east => 'East Coast', :west => 'West Coast', :carib => 'Caribbean',
                :euro => 'Europe', :gulf => 'Gulf of Mexico'}

@@regions = @@region_def.keys


def self.region_name(region)
  name = @@region_def[region.to_sym]
  name = '' if !name
  name
end

def self.active_regions
  @@regions.find_all{|region| self.profiles_for(region).size > 0}
end

def self.profiles_for(region)
  Profile.find(:all).find_all{|prof| prof.get_region == region.to_sym}
end

def get_region
  region = nil
  area = get_area
  if (%w{ (MA) (RI) (ME) (NH) (NJ) (NY) (NC) (VA) (FL) (NS) (DE)}.include?(area))
    region = :east
  elsif (%w{ (CA) (WA) (OR) (HI)}.include?(area))
    region = :west
  elsif (%w{(CB)}.include?(area))
    region = :carib
  elsif (%w{(TX)}.include?(area))
    region = :gulf
  elsif (%w{(UK) (FR)}.include?(area))
    region = :euro
  end

  return region

end

def get_area
  max = 0
  area = ""
  for buoy in self.stations
     if (buoy.weight.to_i > max)
       max = buoy.weight.to_i
       area = buoy.area
     end
  end

  if (area != "")
    area = "(#{area})"
  end

 return area
end

def getReadings
  
  stations.each do |buoy|
    reading = nil
    buoy.readings.each do |read|
      if (read.created_at + 3600) > Time.now
      # reading is still fairly recent
        reading = read
      else 
      # remove old readings
#        puts "DELETE READING"
        buoy.readings.delete(read)  
        read.destroy
      end  
    end
    if (!reading)
 #     puts "GET DATA FROM BUOY \n"
      url = "http://www.ndbc.noaa.gov/station_page.php?station=#{buoy.number}";
      reading = Reading.new
      reading.parse(url)
      buoy.readings << reading
      #reading.save
      end
    end
  
end



def getSurfcasts
  
  stations.each do |buoy|
    buoy.getSurfcasts(self.wave_models)
  end    
  
end



def add_buoy(buoy)
 # puts "add buoy called \n";
 stations << buoy
end

end
