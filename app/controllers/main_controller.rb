class MainController < ApplicationController
  def cloud
    @cloud = Post.cloud_as_js
  end

  def list
    @tag_list = Post.all_tags
  end
end
