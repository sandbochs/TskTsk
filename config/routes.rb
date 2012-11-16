TskTsk::Application.routes.draw do

  resources :users

  resources :lists, except: [:new] do
    resources :todos, only: [:create, :edit, :update, :destroy]
  end

  root to: 'lists#show'

end