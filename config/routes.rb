Rails.application.routes.draw do
  devise_for :users

  # Existing routes

  root to: "welcome#landing"

  # Add resourceful routes for officials
  get 'welcome/index' => 'welcome#index'
  
  resources :officials, only: [:index, :show]
end
