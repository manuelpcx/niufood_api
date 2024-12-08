Rails.application.routes.draw do
  namespace :api do
    resources :devices, only: [:create, :update] do
      collection do
        post :change_status
      end
    end
    resources :restaurants do
      resources :devices, only: [:index]
    end
  end
end
