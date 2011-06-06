class AddMaineNhBuoys < ActiveRecord::Migration
  def self.up
    prof = Profile.find_by_name('Maine')
    buoy = Station.new(:name => 'Georges Bank', :number => '44011',
                       :weight => 1, :area => 'MA')
    buoy2 = Station.new(:name => 'Gulf of Maine', :number => '44005',
                       :weight => 1, :area => 'ME')
    buoy3 = Station.new(:name => 'Central Maine Shelf', :number => '44032',
                       :weight => 1, :area => 'ME')

    prof.stations << buoy
    prof.stations << buoy2
    prof.stations << buoy3


    prof = Profile.find_by_name('NH')

    prof.stations << buoy
    prof.stations << buoy2

    buoy4 = Station.new(:name => 'Isle of Shoals', :number => 'iosn3',
                       :weight => 1, :area => 'NH')
    buoy5 = Station.new(:name => 'Stellwagen Bank', :number => '44029',
                       :weight => 1, :area => 'MA')
    prof.stations << buoy4
    prof.stations << buoy5
  end

  def self.down
  end
end
