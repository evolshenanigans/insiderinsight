Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  authenticate :user do
    resources :officials, only: [:show]
  end

  resources :officials, only: [ :show]
end
