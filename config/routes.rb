Rails.application.routes.draw do
  resources :invitations
  get 'info/about'

  resources :digs do
    resources :images
    resources :dig_participants, except: [:show]
    resources :announcements
    resources :artifacts do
      resources :images
    end
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :profiles, only: [:show]
  #static pages
  get "/about", to: "info#about", as: "about"
  # Defines the root path route ("/")
  root "digs#index"
end
