module MainHelper

  def region_name(region)
    Profile.region_name(region)
  end

  def get_area(profile)
    profile.get_area
  end

end
