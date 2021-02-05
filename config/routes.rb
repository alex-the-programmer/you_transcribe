Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :channels, only: :none do 
    resources :videos, only: :show
  end
end
