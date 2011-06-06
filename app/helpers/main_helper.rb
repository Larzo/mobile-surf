module MainHelper

def in_region(region, prof)
  res = false
  if (region == "")
    return true
  end
  area = get_area(prof)
  if (region == 'east')
    if (%w{ (MA) (RI) (ME) (NH) (NJ) (NY) (NC) (VA) (FL) (NS) (DE)}.any? {|mem| mem == area })
      res = true
    end
  elsif (region == 'west')
    if (%w{ (CA) (WA) (OR) (HI)}.any? {|mem| mem == area })
      res = true
    end  
  end 
    
  return res
end



def get_area(profile)
  max = "0" 
  area = ""
  for buoy in profile.stations 
     if (buoy.weight > max)
       max = buoy.weight
       area = buoy.area
     end 
  end 

if (area != "")
  area = "(#{area})"
end

 return area

end



end
