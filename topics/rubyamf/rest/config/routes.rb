ActionController::Routing::Routes.draw do |map|
  # See how all your routes lay out with "rake routes"
  map.resources :contacts
  
  # Flash/Flex amf gateway controller for RubyAMF
  map.rubyamf_gateway 'rubyamf_gateway', :controller => 'rubyamf', :action => 'gateway'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
