# Include hook code here
# 
class ActiveRecord::Base

def self.load_from_web(models, station)
  east_coast_models = 'nww3 wna nah enp'
  # just cover east coast for now
  models = east_coast_models if models == ""
  thisClass = self.ancestors.shift
  recs = WaveModel::load_from_web(thisClass, models, station)
  return recs
end

def myset_field(fld,val)
  puts "set:" + fld.to_s + " to " + val.to_s
  self.class.columns_hash[fld] = val
  puts self.class.columns_hash[fld]
end

end
