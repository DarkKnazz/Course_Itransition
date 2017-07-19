Rails.application.routes.draw do
  match 'users/sign_up' => redirect('/'), via: :get
  match 'users/sign_in' => redirect('/'), via: :get
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks",  }
    get 'welcome/index'
    root 'welcome#index'
    resources :users, :only => [:show, :index]
    match '*path' => redirect('/'), via: :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
