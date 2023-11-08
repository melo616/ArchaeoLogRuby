Rails.application.routes.draw do

  resources :digs do
    resources :dig_participants, except: [:show]
    resources :artifacts
    resources :dig_images
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "digs#index"
end
