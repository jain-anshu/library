Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # resources :users
  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show', as: 'user'
  post 'users', to: 'users#create'
  put 'users/:id', to: 'users#update'
end
