Rails.application.routes.draw do
  root 'events#index'

  resources :teams do
    resources :events, only: [:index]
    resources :members
    resources :projects, only: [:index, :new, :create]
    resources :users
  end

  resources :projects, only: [:show, :update] do
    resources :todos do
      resources :comments, only: [:create]
    end

    resources :todo_lists do
      resources :comments, only: [:create]
    end
  end
end
