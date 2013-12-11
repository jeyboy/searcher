Searcher2::Application.routes.draw do
  devise_for :users

  resources :posts do
    post 'dump', on: :collection
  end

  resources :categories, except: :index

  resources :tags, only: :create do
    get 'posts', on: :member
  end

  resources :taggables, only: :destroy

  resource :search, only: :create, controller: 'search'

  resources :invites, only: [:new, :create]

  resource :dashboard, controller: 'dashboard', only: [:show]

  root to: 'dashboard#show'
end
