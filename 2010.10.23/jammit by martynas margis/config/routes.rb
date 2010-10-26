JammitExample::Application.routes.draw do
  resources :users do
    collection do
      get :images
    end
  end
  match "/images" => "users#images", :as => :images
  root :to => "users#index"
end
