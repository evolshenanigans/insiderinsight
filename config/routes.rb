Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    devise_for :users

    root "welcome#index"

    authenticate :user do
      resources :officials, only: [:show]
    end

    resources :officials, only: [:show]
  end
end
