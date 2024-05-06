Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do # good job!
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    devise_for :users

    root "welcome#index"

    authenticate :user do
      resources :officials, only: [:show]
    end

    # duplicated route? officials are accessible to non authenticated users and also authenticated users
    resources :officials, only: [:show]
  end
end
