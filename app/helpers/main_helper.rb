module MainHelper


# code moved into Profile model

=begin

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

=end

def region_name(region)
  Profile.region_name(region)
end

def get_area(profile)
  profile.get_area
end


end
