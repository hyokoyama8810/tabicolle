Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get '/about',  to:'static_pages#about'

  post '/posts/create', to:'posts#create'

  resources :users, :only => [:show]
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

end
