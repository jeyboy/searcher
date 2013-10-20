class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from 'ActionController::RedirectBackError', with: ->{ redirect_to :root }

  def init_sidebar
    @categories = Category.all.sort
    @tags = Tag.all.sort.group_by{|v| v.name.first}
  end
end
