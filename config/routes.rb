Socializer::Application.routes.draw do
  resources :user_groups


  resources :status_updates


  resources :relationships


  get "wall/index"

  resources :groups do
  	member do
  		post :join
  		post :leave
  	end
  end


  resources :profiles

  authenticated :user do
    root :to => 'post#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end