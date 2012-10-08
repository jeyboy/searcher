class MainController < ApplicationController
  def show
    @cloud = Post.cloud_as_js
  end
end
