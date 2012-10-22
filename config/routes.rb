Searcher::Application.routes.draw do
  root :to => 'main#cloud'

  resource :main, :only => [] do
    match "cloud" => "main#cloud"
    match "show"  => "main#list"
  end

  resources :posts do
    get :relevant_mini, :on => :collection
    get :relevant, :on => :collection
    get :trash, :on => :collection
    get :index_by_tags, :on => :collection
    get :search, :on => :collection
    post :preprocess, :on => :collection

    post :delete_tag, :on => :member
    get :to_trash, :on => :member
    get :from_trash, :on => :member
    get :related, :on => :member
  end
  resources :topics, :except => :destroy
  resources :tags, :only => :index
end
