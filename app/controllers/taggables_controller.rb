class TaggablesController < ApplicationController
  def destroy
    taggable = Taggable.where(id: params[:id]).first
    render json: taggable.destroy
  end
end
