TskTsk::Application.routes.draw do

  resources :users

  resources :lists do
    resources :tasks
  end

  root to: 'lists#show'

end