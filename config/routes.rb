Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root 'welcome#index'
  resources :posts do
    resources :steps, :only => [:create, :update, :edit, :destroy, :clear]
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users, :only => [:show, :index, :update, :edit, :destroy]
  resources :posts, :only => [:index, :show, :update, :edit, :destroy]
  resources :categories, :only => [:create, :update, :edit, :destroy]
  get 'tags/:tag', to: 'posts#index', as: :tag
  post 'update_step', to: 'steps#update_step', as: 'update_step'
  resources :steps do
    put :sort, on: :collection
  end
  resources :posts do
    get :autocomplete_category, :on => :collection
  end

  mount ActionCable.server => '/cable'
  match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
