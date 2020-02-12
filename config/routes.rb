Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create, :index] do
    resources :lists
  end
  get '/recipes/most_popular' => 'recipes#most_popular', as: 'most_popular_recipe'
  resources :recipes
  resources :items, only: [:index]
  get '/users/:user_id/lists/:id/edit_details' => 'lists#edit_details', as: "edit_details_user_list"
  patch '/users/:user_id/lists/:id/details' => 'lists#update_details'
  put '/users/:user_id/lists/:id/details' => 'lists#update_details'
  get '/login' => 'sessions#new', as: "login"
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  root :to => "users#home"
  get '/auth/facebook/callback' => 'sessions#omniauth_create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
