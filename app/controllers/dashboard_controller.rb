class DashboardController < ApplicationController
  def show
    @posts = Post.all

    init_sidebar
  end
end
