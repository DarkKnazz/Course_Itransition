Rails.application.routes.draw do
  resources :posts
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'welcome#index'
  resources :users, :only => [:show, :index, :update, :edit, :destroy]
  resources :posts, :only => [:index, :show, :update, :edit, :destroy]
  match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
