require 'sidekiq/web'

Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin' unless Rails.env.production?
  # mount Sidekiq::Web => "/sidekiq" unless Rails.env.production?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :channels, only: :none do 
    resources :videos, only: :show
  end

  # root 'home#index'
end
