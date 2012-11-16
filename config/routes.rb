TskTsk::Application.routes.draw do
  resources :sessions
  resources :users, only: [:new, :create]

  resources :lists, except: [:new] do
    resources :todos, only: [:create, :edit, :update, :destroy]
  end

  root to: 'sessions#new'
end