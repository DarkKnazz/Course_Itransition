Rails.application.routes.draw do
  get 'users/update'
  post 'users/update'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
    root 'welcome#index'
    resources :users, :only => [:show, :index, :update]
    match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
