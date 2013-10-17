Searcher2::Application.routes.draw do
  resources :posts

  resources :categories

  resources :tags, only: :create

  resources :taggables, only: :destroy

  resource :dashboard, controller: 'dashboard', only: [:show]

  root to: 'dashboard#show'
end
