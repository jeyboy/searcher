Searcher::Application.routes.draw do
  root :to => 'main#show'

  resource :main
  resources :posts do
    get :relevant, :on => :collection
    get :index_by_tags, :on => :collection
    get :search, :on => :collection
    post :preprocess, :on => :collection

    post :delete_tag, :on => :member
    get :related, :on => :member
  end
  resources :topics, :except => :destroy
  resources :categories do
    get :topics, :on => :member
  end
  resources :tags, :only => :index
end
