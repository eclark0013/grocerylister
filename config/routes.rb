Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    resources :lists
  end
  resources :recipes
  resources :items, only: [:index]
  get '/users/:user_id/lists/:id/edit_categories' => 'lists#edit_categories', as: "edit_categories_user_list"
  patch '/users/:user_id/lists/:id/categories' => 'lists#update_categories'
  put '/users/:user_id/lists/:id/categories' => 'lists#update_categories'
  get '/users/:user_id/lists/:id/finalize' => 'lists#finalize', as: "finalize_user_list"
  patch '/users/:user_id/lists/:id/finalize' => 'lists#final_update'
  put '/users/:user_id/lists/:id/finalize' => 'lists#final_update'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  root :to => "users#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
