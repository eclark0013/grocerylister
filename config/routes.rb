Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    resources :lists
  end
  resources :recipes
  resources :items, only: [:index]
  get '/users/:user_id/lists/:id/edit_details' => 'lists#edit_details', as: "edit_details_user_list"
  patch '/users/:user_id/lists/:id/details' => 'lists#update_details'
  put '/users/:user_id/lists/:id/details' => 'lists#update_details'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  root :to => "users#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
