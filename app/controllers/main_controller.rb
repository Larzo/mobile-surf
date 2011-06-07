class MainController < ApplicationController

layout :determine_layout
helper :main

def all
  @regions = Profile.active_regions
end

def forcast
 @region = params[:region]
 @profiles = Profile.profiles_for(@region)

 @region_msg = "wave models: #{@region}"
end

def region
 #@profiles = Profile.find(:all)
 @region = params[:region]
 @profiles = Profile.profiles_for(@region)
 @region_msg = "region:#{@region}"
end

def index
@region = ""
@region_msg = "all regions"
@profiles = Profile.find(:all)
end



def show_profile

name = params[:name]
name = name.gsub(/-/,' ')
@prof = Profile.find(:first,
:conditions => ["name = :name",{:name => name}])

if @prof
  @msg = "Profile: #{name}"
  @prof.getReadings()
else
  @msg = "Profile for '#{name}' was not found"
end    


end




def show_surfcast

name = params[:name]
name = name.gsub(/-/,' ')
@prof = Profile.find(:first,
:conditions => ["name = :name",{:name => name}])

if @prof
  @msg = "Profile: #{name}"
  @prof.getSurfcasts()
else
  @msg = "Profile for '#{name}' was not found"
end    


end



def show_full_surfcast
#puts "called here"
 station = params[:station]
 @show_period = (params[:period]) ? true : false

 @station = Station.find(:first,
  :conditions => ["number = :number",{:number => station}])

#puts "after"

if @station 
  @msg = "Station: #{@station.name}"
  #puts "get"
  @station.getSurfcasts()
else
  @msg = "Station #{station} was not found"  
end  


end 



end
