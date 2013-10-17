class TagsController < ApplicationController
  def create
    @tag = Category.new(tag_params)

    render json: {status: @tag.save}
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
