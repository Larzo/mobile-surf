class AddStations < ActiveRecord::Migration
  def self.up
    prof = Profile.find_by_name('NE offshore')
    prof.stations << buoy = Station.new(:name => 'Nantucket', :number => '44008',
                          :weight => 1, :area => 'MA')
    prof.stations << Station.new(:name => 'SE Cape Cod', :number => '44018',
                        :weight => 1, :area => 'MA')
    prof.stations << Station.find_by_number('44005')
    prof.stations << Station.find_by_number('44011')

    prof2 = Profile.find_by_name('Rhode Island')
    prof2.stations << buoy
    prof2.stations << Station.new(:name => 'Long Island', :number => '44025',
                        :area => 'NY', :weight => '1')
    prof2.stations << Station.new(:name => 'Montauk', :number => '44017', :area => 'NY')
    prof2.stations << Station.new(:name => 'Buzzards Bay', :number => 'buzm3', :area => 'MA')
    prof3 = Profile.find_by_name('Hatteras')
    prof3.stations << Station.new(:name => 'East of Hatteras', :number => '41001',
                                   :area => 'NC')
    prof3.stations << Station.new(:name => 'Diamond Shoals', :number => '41025', :area => 'NC')
    prof3.stations << Station.new(:name => 'Virginia Beach', :number => '44014', :area => 'VA')
    prof3.stations << Station.new(:name => 'Frying Pan Shoals', :number => '41013', :area => 'NC')

  end

  def self.down
  end
end
