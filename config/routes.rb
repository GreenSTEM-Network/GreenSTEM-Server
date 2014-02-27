SolarSunflower::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users

  post "/data_collection", to: 'data_collection#submit'

  #aliased to perhaps save amount of data needed to be hardcoded on client ardruino
  post "/dc", to: 'data_collection#submit'

  get "/dc/index/(:site_id)", to: 'data_collection#index', :as => 'data_collections'

  get "/sites", to: 'sites#index'

  get "/public/summary", to: 'summary#index'

  resources :sites

  namespace :api do
    namespace :v1 do
      resources :sites
    end
  end

end
