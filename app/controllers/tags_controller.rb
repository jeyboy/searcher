class TagsController < ApplicationController
  def edit
    @tag = Tag.where(id: params[:id]).first
    render json: {content: render_to_string('tags/_form', locals: {:@tag => @tag}, layout: false)}
  end

  def update
    @tag = Tag.where(id: params[:id]).first
    if @tag
      render(json: {status: @tag.update_attributes(params[:tag]), id: @tag.id, text: @tag.name})
    end || render(json: {status: @tag.save, id: @tag.id, text: @tag.name})
  end

  def create
    @tag = Tag.new(tag_params)

    render json: {status: @tag.save, id: @tag.id, text: @tag.name}
  end

  def posts
    @tag = Tag.where(id: params[:id]).first
    if @tag
      @posts = @tag.posts
      init_sidebar
    else
      redirect_to :back, alert: 'Tag not found'
    end
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
