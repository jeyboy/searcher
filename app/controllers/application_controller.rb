class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :authenticate_user!

  rescue_from 'ActionController::RedirectBackError', with: ->{ redirect_to :root }

  def init_sidebar
    @categories = Category.joins(:posts).uniq.order('name').all
    @tags = Tag.joins(:posts).uniq.order('name').all.group_by{|v| v.name.first}
  end
end
