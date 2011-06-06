
require 'net/http'


module WaveModel

  DOMAIN = 'polar.ncep.noaa.gov'
  PATH = '/waves/latest_run/'
  EXT = 'bull'
  
  # be able to test this when there is no web connection
  WEB_IS_AVAILABLE = true
  
def self.load_from_web(myclass, wave_model_abrev, station)
  @readings = Array.new
  wave_model = wave_model_abrev.split(/\s+/)
  wave_model = [wave_model]  if wave_model.class != Array
  done = (WEB_IS_AVAILABLE) ? false : true

  
  @readings = [{:day => 21, :hour => 7, :height => 4.5, :direction => 242}] if !WEB_IS_AVAILABLE
  
  while !done
    model = wave_model.shift
    path = PATH + model + '.' + station.to_s + '.' + EXT  
    # puts DOMAIN + path
    resp = Net::HTTP.get_response(DOMAIN, path)
    if resp.code == '200'
      parse(resp)
      done = true
    end          
    done = true if wave_model.size == 0
    end
 
 @recs = Array.new

 @readings.each do |rd|
   rec = myclass.new
   #rec.day = 15
   rec.day = rd[:day]
   rec.hour = rd[:hour]
   rec.height = rd[:height]
   rec.direction = rd[:direction]
   rec.period = rd[:period]
#   rd.each_pair do |ky,val|
#     rec.myset_field(ky,val)
#     puts "the day:" + rec.day.to_s
#   end
   rec.save
   @recs << rec  
 end  

 @recs   
end


def self.parse(resp)
  lines = resp.body.split(/\n/)
  in_readings = false
  horizontals = 0
  
  lines.each do |ln|
    is_horizontal = (ln =~ /^\s*\+---/ ) ? true : false
    in_readings = (horizontals == 2 && !is_horizontal) ? true : false
    horizontals += 1 if is_horizontal
    if in_readings
      parse_line(ln)
    end  
  end  
end

def self.parse_line(line)
   reading = Hash.new
   direction = 0 
   fld_max = 0.0
   fields = line.split(/\|/)
   
   fields.each_with_index do |fld, idx|
   
    case idx
      when 1
        token = fld.scan(/\d+/) 
        reading[:day] = token[0]
        reading[:hour] = token[1]
      when 2
        token = fld.scan(/\d+\.\d+/) 
        reading[:height] = token[0]
       else
          token = fld.scan(/\d+\.\d+/)
          token2 = fld.scan(/\d+/)
          height = token[0].to_f
          if (height > fld_max)
            fld_max = height
            reading[:period] = token[1]            
            reading[:direction] = token2[4]
          end
          
      end  
    end
    
   # if [0,3,6,9,12,15,18,21].include? reading[:hour].to_i     
   if ([0,6,12,18].include? reading[:hour].to_i)
     @readings << reading
   end  
   #p reading
   #puts "max:" + fld_max.to_s
   #puts 'dir:' + direction
end  


end


