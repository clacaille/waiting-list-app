Rails.application.routes.draw do
  devise_for :users
  root to: 'requests#new'

  resources :requests, only: [ :new, :create ]

  get 'confirm', to: 'requests#confirm'
end
