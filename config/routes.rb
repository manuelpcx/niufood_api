Rails.application.routes.draw do
  namespace :api do
    resources :devices, only: [:create, :update]
    resources :restaurants
  end
end
