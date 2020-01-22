Rails.application.routes.draw do
  resources :users do
    resources :lists
  end
  resources :recipes
  resources :items
  resources :stores
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  root :to => "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
