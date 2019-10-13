Rails.application.routes.draw do
  get 'tasks/index', to: 'tasks#index'
  get 'tasks/new', to: 'tasks#new'
  post 'tasks/new', to: 'tasks#new'
  post 'tasks/create', to: 'tasks#create'
  get 'tasks/:id', to: 'tasks#show'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :tasks
end
