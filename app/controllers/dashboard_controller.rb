class DashboardController < ApplicationController
  def show
    @posts = Post.all
  end
end
