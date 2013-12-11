class PostsController < ApplicationController
  layout :current_layout

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    init_sidebar
    @posts = Post.includes(taggables: :tag).all
    render template: 'posts/alt_index'
  end

  def show
    init_sidebar
  end

  def new
    @post = Post.new
  end

  def edit;  end

  def create
    params[:post][:author_name] = current_user.email
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html {
          if params['btn-continue']
            redirect_to :new_post
          else
            redirect_to @post, notice: 'Post was successfully created.'
          end
        }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def dump
    require 'backuper'
    ::Backuper.dump(ActiveRecord::Base.connection)
    send_file(::Backuper.file_path)
  end

  private
    def set_post
      @post = Post.includes(taggables: :tag).where(id: params[:id]).first
      redirect_to(:root, alert: 'Post not exist') unless @post
    end

    def post_params
      params.require(:post).permit(:name, :author_name, :category_id, :body, tag_ids: [])
    end

  def current_layout
    if %w(new edit create).include?(params[:action])
      'simple'
    else
      'application'
    end
  end
end
