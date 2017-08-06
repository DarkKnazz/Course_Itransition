Rails.application.routes.draw do
  root 'welcome#index'
  mount ActionCable.server => '/cable'

  resources :users, :only => [:show, :index, :update, :edit, :destroy]
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :posts, :only => [:index, :show, :update, :edit, :destroy]
  resources :posts do
    resources :steps, :only => [:create, :update, :edit, :destroy, :clear]
  end
  resources :posts do
    get :autocomplete_category, :on => :collection
  end
  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :steps do
    put :sort, on: :collection
  end
  post 'update_step', to: 'steps#update_step', as: 'update_step'

  resources :categories, :only => [:create, :update, :edit, :destroy]

  post '/rate' => 'rater#create', :as => 'rate'
  match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
