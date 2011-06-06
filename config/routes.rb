MobileSurf2011::Application.routes.draw do |map|


  map.resources :weather_locations

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'


  map.connect '/', :action => 'index', :controller => 'main'
  map.connect 'region/:region', :action => 'region', :controller => 'main'
  map.connect 'forcast/:region', :action => 'forcast', :controller => 'main'

  map.connect 'prof/:name', :action => 'show_profile', :controller => 'main'
  map.connect 'profmodel/:name', :action => 'show_surfcast', :controller => 'main'
  map.connect 'buoymodel/:station', :action => 'show_full_surfcast', :controller => 'main'
  map.connect 'weather/:name', :action => 'show_weather', :controller => 'weather'
  map.connect 'tides/:name', :action => 'show_tides', :controller => 'weather'


  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
