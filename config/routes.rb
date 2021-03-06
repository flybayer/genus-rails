Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'about' => 'static_pages#about'

  resources :organizations, path: "", only: [:show] do
    resources :people, as: 'users', controller: 'users',
      only: [:create, :show, :edit, :update, :index]

    resources :groups, only: [:create, :show, :index, :destroy] do
      # New conversations
      resources :messages, only: [:create]
      resources :roles, only: [:new, :create]
    end

    resources :conversations, only: [:show, :update] do
      # New messages in an existing converation
      resources :messages, only: [:create]
    end

    # resources :messages, only: [:update]
    resources :roles, only: [:show, :edit, :update, :destroy]
  end

  root 'static_pages#home'
end
