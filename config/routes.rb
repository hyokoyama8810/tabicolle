Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'static_pages#home'
  resources :users, only: [:show]
  resources :posts, only: [:index, :create, :new, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'follow/:id' => 'relationships#follow', :as => 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', :as => 'unfollow' # フォロー外す
end
