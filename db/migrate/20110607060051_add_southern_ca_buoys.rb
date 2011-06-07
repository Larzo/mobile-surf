class AddSouthernCaBuoys < ActiveRecord::Migration
  def self.up
    prof = Profile.new(:name => 'Southern CA')
    prof.save
    prof.stations << Station.new(:name => 'Tanner Banks', :number => '46047',
                                 :area => 'CA')
    prof.stations << Station.new(:name => 'Coronado Islands', :number => '46232', :area => 'CA')
    prof.stations << Station.new(:name => 'Cape San Martin', :number => '46028', :area => 'CA')
    prof.stations << Station.new(:name => 'Santa Monica Basin', :number => '46025', :area => 'CA')
    prof.stations << Station.new(:name => 'Santa Barbara', :number => '46054', :area => 'CA')

    prof2 = Profile.find_by_name('Florida')
    prof2.stations << Station.new(:name => 'Saint Augustine', :number => '41012', :area => 'FL')
    prof2.stations << Station.new(:name => 'Cape Canaveral', :number => '41009', :area => 'FL')
    prof2.stations << Station.new(:name => 'Canaveral East', :number => '41010', :area => 'FL')
  end

  def self.down
  end
end
