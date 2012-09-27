class MainController < ApplicationController
  def show
    @cloud = Post.tag_counts_on(:tags)
  end
end
