class SearchController < ApplicationController
  def create
    @phrase = params[:search][:value]
    init_sidebar
    @posts = Post.
        includes(taggables: :tag).
        where(["posts.name LIKE :like_piece OR posts.body LIKE :like_piece OR tags.name = :piece", {like_piece: "%#{@phrase}%", piece: @phrase}])
  end
end
