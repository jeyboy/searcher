class DashboardController < ApplicationController
  def show
    @posts = Post.all

    @categories = Category.all
    @tags = Tag.all.group_by{|v| v.name.first}
  end
end
