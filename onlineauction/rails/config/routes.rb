ActionController::Routing::Routes.draw do |map|
   map.resources :bids
   map.resources :sellers, :has_many => [:auctions]
   map.resources :auctions, :has_many => [:bids], :has_one => [:item]
   map.resources :items
   map.resources :users, :has_many => [:bids], :has_one => [:seller]

   if RAILS_ENV == "test"
     map.resources :fixtures, :new => { :test_results => :post }
     map.crossdomain '/crossdomain.xml', :controller => 'fixtures', :action => 'crossdomain'
   end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  # map.resources :products

  # Sample resource route with options:
  # map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  # map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end