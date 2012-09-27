class CategoriesController < ApplicationController
  before_filter :preinit, :only => [:show, :edit, :update, :destroy]

  def index
    @categories = paging(Category)
  end

  def show
  end

  def edit
  end

  def create
    render :json =>  if (category = Category.create(params[:category])).persisted?
      {:status => true, :id => category.id, :name => category.name}
    else
      {:status => false }
    end
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to :root
    else
      render :action => :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to :root
  end

  def topics
    if (params[:cached].present?)
      render :json => {:data => Category.cached_topics(params[:id].to_i) }
    else
      @category = Category.includes(:topics).find_by_id(params[:id])
      render :json => {:data => help.prepare_list(@category.topics).join}
      topic_path
    end
  end

private
  def preinit
    @category = Category.find_by_id(params[:id])
    redirect_to :root, :alert => "Access denied" if @category.nil?
  end

  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include CategoriesHelper
  end
end
