class AddCaribeanBuoys < ActiveRecord::Migration
  def self.up
    prof = Profile.new(:name => 'Caribbean Sea')
    prof.save
    prof.stations << Station.new(:name => 'SW Atlantic', :number => '41043', :area => 'CB')
    prof.stations << Station.new(:name => 'Eastern Caribbean', :number => '42059', :area => 'CB')
    prof.stations << Station.new(:name => 'Western Atlantic', :number => '41040', :area => 'CB')
  end

  def self.down
  end
end
