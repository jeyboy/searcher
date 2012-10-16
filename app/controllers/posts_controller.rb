class PostsController < ApplicationController
  before_filter :preinit, :only => [:related, :destroy, :edit, :update, :show, :delete_tag, :to_trash]
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
    unless topic
      redirect_to(new_post_path, :alert => "Topic not find") unless topic
    else
      @post = topic.posts.build(params[:post])
      @post.tag_list = params[:tag].map(&:last) unless params[:tag].blank?
      if (@post.save)
        redirect_to relevant_posts_path
      else
        init_vars
        render :action => :new
      end
    end
  end

  def update
    @post.topic_id = params[:post].delete(:topic_id)
    @post.tag_list << params[:tag].map(&:last) unless params[:tag].blank?

    if @post.update_attributes(params[:post])
      redirect_to relevant_posts_path
    else
      render :action => :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to relevant_posts_path
  end

  def relevant_mini
    @posts = Post.includes(:topic)
  end

  def relevant
    @posts = paging(Post, 20)
    render :action => :index
  end

  def trash
    @posts = paging(Post.trash, 20)
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
      mime.js   do
        @remote = true
        render :action => :index
      end
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

  def to_trash
    @post.trash = true
    @post.save
    respond_with do |mime|
      mime.js {render :nothing => true}
    end
  end

  def from_trash
    @post = Post.unscoped.find_by_id(params[:id])
    @post.trash = false
    @post.save
    respond_with do |mime|
      mime.js {render :nothing => true}
    end
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
