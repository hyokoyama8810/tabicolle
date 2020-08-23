Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get '/about',  to:'static_pages#about'

  # get 'users/show'

  resources :users, :only => [:show]
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
