class TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)

    render json: {status: @tag.save, id: @tag.id, text: @tag.name}
  end

  def posts
    @tag = Tag.where(params[:id]).first
    if @tag
      @posts = @tag.posts
    else
      redirect_to :back, alert: 'Tag not found'
    end
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
