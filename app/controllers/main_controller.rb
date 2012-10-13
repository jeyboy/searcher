class MainController < ApplicationController
  def cloud
    @cloud = Post.cloud_as_js
  end

  def list
    @tag_list = Post.all_tags.sort
    @count = @tag_list.count
    @tag_list = @tag_list.group_by {|t| t.first}
  end
end
