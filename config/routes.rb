Rails.application.routes.draw do
  # Routes for API documentaion
  mount Apidoco::Engine, at: '/'
  namespace :api do
    namespace :v1 do
      resources :restaurants, only: [:create, :index] do
        resources :reservations, only: [:create, :index, :update]
      end
    end
  end
end
