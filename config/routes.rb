Rails.application.routes.draw do
  resources :users, only: [:show] do
    resources :lists, only: [:index]
  end
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update]
  resources :items, only: [:index]
  resources :stores, only: [:index]
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  root :to => "users#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
