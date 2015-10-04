Rails.application.routes.draw do
  devise_for :users

  resource :db, only: [:create, :update]

  resources :posts

  resources :categories, except: :index

  resources :tags, only: [:create, :edit, :update] do
    get 'posts', on: :member
  end

  resources :taggables, only: :destroy

  resource :search, only: :create, controller: 'search'

  resources :invites, only: [:new, :create]

  root to: 'posts#index'
end
