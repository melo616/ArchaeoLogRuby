Rails.application.routes.draw do
  resources :dig_participants, only: [:new, :create, :destroy]
  resources :digs
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "digs#index"
end
