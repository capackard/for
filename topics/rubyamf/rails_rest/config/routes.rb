ActionController::Routing::Routes.draw do |map|
  map.resources :contacts
    
  map.rubyamf_gateway 'rubyamf_gateway', :controller => 'rubyamf', :action => 'gateway'
end
