Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root 'welcome#index'
  resources :posts do
    resources :steps, :only => [:create, :update, :edit, :destroy, :clear]
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users, :only => [:show, :index, :update, :edit, :destroy]
  resources :posts, :only => [:index, :show, :update, :edit, :destroy]
  get 'tags/:tag', to: 'posts#index', as: :tag
  post 'clear', to: 'steps#clear', as: 'clear'
  match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
