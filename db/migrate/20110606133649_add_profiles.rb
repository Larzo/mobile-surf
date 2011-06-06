class AddProfiles < ActiveRecord::Migration
  def self.up
    prof = Profile.new(:name => 'Maine')
    prof.save

    buoy1 = Station.new(:name => 'Portland Maine', :area => 'ME',
                       :number => '44007', :weight => 1)
    buoy2 = Station.new(:name => 'Western Maine Shelf', :area => 'ME',
                       :number => '44030', :weight => 1)

    prof.stations << buoy1
    prof.stations << buoy2


    prof = Profile.new(:name => 'NH')
    prof.save
    prof.stations << buoy1
    buoy3 = Station.new(:name => 'Boston Harbor', :area => 'MA', :weight => 1,
                        :number => '44013')
    prof.stations << buoy3

    prof = Profile.new(:name => 'Florida')
    prof.save
    prof = Profile.new(:name => 'NE offshore')
    prof.save
    prof = Profile.new(:name => 'Hatteras')
    prof.save
    prof = Profile.new(:name => 'Rhode Island')
    prof.save

    prof = Profile.new(:name => 'Mid Atlantic')
    prof.save
    prof = Profile.new(:name => 'Nova Scotia')
    prof.save
    prof = Profile.new(:name => 'Long Island')
    prof.save





  end

  def self.down
  end
end
