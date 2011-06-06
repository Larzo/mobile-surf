require 'net/http'


class Profile < ActiveRecord::Base
has_and_belongs_to_many :stations


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
