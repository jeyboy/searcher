Searcher2::Application.routes.draw do
  resources :posts

  resources :categories

  resources :tags, only: :create do
    get 'posts', on: :member
  end

  resources :taggables, only: :destroy

  resource :dashboard, controller: 'dashboard', only: [:show]

  root to: 'dashboard#show'
end
