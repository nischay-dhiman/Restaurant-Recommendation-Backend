Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :restaurants, only: :index do
    collection do
      get :recommendations
    end

    member do
      post :rating
      post :favorite
    end
  end
end
