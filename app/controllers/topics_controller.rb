class TopicsController < ApplicationController
  before_filter :init, only: [:edit, :update, :show]

  def index
    @topics = paging(Topic.order('name'), 50)
  end

  def show
    @posts = paging(@topic.posts)
  end

  def create
    topic = Topic.create(params[:topic])
    # todo: topic.to_json override
    render json: if topic.persisted?
        {
            status: true,
            id: topic.id,
            name: topic.name
        }
      else
        {
            status: false
        }
    end
  end

  def edit;  end

  def update; end

private
  def init
    @topic = Topic.find_by_id(params[:id])
    redirect_to :root, :alert => 'Access denied' if @topic.nil?
  end
end
