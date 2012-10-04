class MainController < ApplicationController
  def show
    @cloud = Post.cloud
  end
end
