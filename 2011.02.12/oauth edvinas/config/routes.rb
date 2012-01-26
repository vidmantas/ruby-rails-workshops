SandboxOauth::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

#  match 'oauth_consumers/:oauth_token/callback', :controller => "oauth_consumers", :action => "callback"
  resources :oauth_consumers

  root :to => "session#login"
  match ':controller(/:action(/:id(.:format)))'
end
