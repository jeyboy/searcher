class PostsController < ApplicationController
  before_filter :preinit, :only => [:related, :destroy, :edit, :update, :show, :delete_tag]
  before_filter :init_vars, :only => [:new, :edit]
  respond_to :html, :js

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    category = @post.topic.category
    @category_id = category.id
    @topics = category.topics
    render :action => :new
  end

  def create
    topic = Topic.find_by_id(params[:post].delete(:topic_id))
    (redirect_to(topics_path, :alert => "Topic not find") and return) unless topic
    @post = topic.posts.build(params[:post])
    @post.tag_list = params[:tag].map(&:last) unless params[:tag].blank?
    if (@post.save)
      redirect_to topic_path(@post.topic_id)
    else
      render :action => :new
    end
  end

  def update
    @post.topic_id = params[:post].delete(:topic_id)
    @post.tag_list << params[:tag].map(&:last) unless params[:tag].blank?

    if @post.update_attributes(params[:post])
      redirect_to topic_path(@post.topic_id)
    else
      render :action => :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to topic_path(@post.topic_id)
  end

  def relevant
    @posts = paging(Post.includes(:topic))
    render :action => :index
  end

  def related
    @posts = paging(@post.includes(:topic).find_related_tags)
    render :action => :index
  end

  def index_by_tags
    @posts = paging(Post.includes(:topic).by_one_of_the_tags(params[:tags]))
    respond_with do |mime|
      mime.html { render :action => :index }
      mime.js   { render :action => :index }
    end
  end

  def delete_tag
    @post.tag_list.remove(params[:tag])
    render :json => {:status => @post.save}
  end

  def search
    @posts = paging(Post.search(:name_or_body_contains => (@criterion = params[:search][:search])).relation)
  end

  def preprocess
    render :text => Post.prepare_content(params[:content])
  end

protected
  def init_vars
    @categories = Category.all
    @tags = Post.all_tags
  end

  def preinit
    @post = Post.find_by_id(params[:id])
    redirect_to :root, :alert => "Access denied" if @post.nil?
  end
end
