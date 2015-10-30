Rails.application.routes.draw do
  root 'events#index'

  resources :teams do
    resources :events, only: [:index]
    resources :members
    resources :projects, only: [:index, :new, :create]
    resources :users
  end

  resources :projects, only: [:show, :update] do
    resources :todo_lists do
      resources :todos do
        member do
          %w(finish assign reassign reschedule).each do |action|
            post action, to: "todos##{action}"
          end
        end

        resources :comments, only: [:create, :destroy]
      end

      resources :comments, only: [:create, :destroy]
    end
  end
end
