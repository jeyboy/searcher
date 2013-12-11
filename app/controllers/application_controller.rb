class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  #require 'backuper'
  #before_filter -> {::Backuper.dump(ActiveRecord::Base.connection)}

  protect_from_forgery with: :exception

  rescue_from 'ActionController::RedirectBackError', with: ->{ redirect_to :root }

  def init_sidebar
    @categories = Category.joins(:posts).uniq.order('name').all
    @tags = Tag.joins(:posts).uniq.order('name').all.group_by{|v| v.name.first}
  end
end
