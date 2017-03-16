Rails.application.routes.draw do
  resources :events
  resources :follows
  resources :subscriptions
  resources :tags
  resources :books
  resources :libraries
  resources :users
  get "/github_auth", to: "authentication#github"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
