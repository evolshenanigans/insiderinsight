Rails.application.routes.draw do
  devise_for :users

  # Existing routes
  root "welcome#index"

  # Add resourceful routes for officials
  resources :officials, only: [:show, :index] #
end
