class MainController < ApplicationController
  def cloud
    @clouds = Post.cloud_as_js
  end

  def list
    @cloud = Post.cloud_as_js
    @tag_list = Post.all_tags.sort
    @tags_count = @tag_list.count
    @tag_list = @tag_list.group_by(&:first)
  end
end
