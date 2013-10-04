class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.where('name = %?%', params[:tag])
  end
end
