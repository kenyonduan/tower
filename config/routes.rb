Rails.application.routes.draw do
  root 'events#index'

  resources :projects
  resources :calendars
  resources :todos
  resources :comments
  resources :users
end
