class TopicsController < ApplicationController
  before_filter :preinit, :only => [:edit, :update, :show]

  def index
    @topics = paging(Topic.order("name"), 50)
  end

  def show
    @posts = paging(@topic.posts)
  end

  def create
    render :json => if (topic = Topic.create(params[:topic]))
        {:status => true, :id => topic.id, :name => topic.name}
      else
        {:status => false }
    end
  end

  def edit

  end

  def update

  end

private
  def preinit
    @topic = Topic.find_by_id(params[:id])
    redirect_to :root, :alert => "Access denied" if @topic.nil?
  end
end
