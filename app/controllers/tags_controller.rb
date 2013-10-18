class TagsController < ApplicationController
  def create
    @tag = Tag.new(tag_params)

    render json: {status: @tag.save, id: @tag.id, text: @tag.name}
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
