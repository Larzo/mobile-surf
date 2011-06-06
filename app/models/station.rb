class Station < ActiveRecord::Base
has_and_belongs_to_many :profiles
has_many :readings
has_many :surfcasts

cattr_reader :per_page
@@per_page = 10


def getSurfcasts(wave_models = "")
  # puts Time.now.to_s
  curtime = Time.now
  wave_models = "" if wave_models == nil
  
  deleted = false
  surfcasts.each do |read|
      crtime = read.created_at
      expire = crtime + 3600
      if Time.now > expire
        deleted = true
        read.destroy
      end 
    end
    self.save!
    if (self.surfcasts.size <= 0) || deleted
      forcasts = Surfcast.load_from_web(wave_models,self.number)
      forcasts.each do |f|  
        f.save!
        surfcasts << f
      end
    end
end
  




end
