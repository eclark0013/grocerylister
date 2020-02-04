Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :lists
  end
  resources :recipes
  resources :items, only: [:index]
  resources :stores, only: [:index]
  get '/users/:user_id/lists/:id/prepare' => 'lists#prepare'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  root :to => "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
