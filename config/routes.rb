Rails.application.routes.draw do

  get '/houses/own', to: 'houses#own'
  resources :houses

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations',
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
