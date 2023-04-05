require 'jwt_secure'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # mount JwtSecure::Engine

  namespace :api do
    post "/login", to: "auth#login"
    get "/logout", to: "auth#logout"
    get "/test", to: "test#some"
  end

end
