TskTsk::Application.routes.draw do

  get 'log_out' => 'sessions#destroy', as: 'log_out'
  
  resources :sessions
  resources :users, only: [:create]

  resources :lists, except: [:new] do
    resources :todos, only: [:create, :edit, :update, :destroy]
  end

  root to: 'sessions#new'
end