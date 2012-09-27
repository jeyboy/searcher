class ApplicationController < ActionController::Base
  protect_from_forgery

protected
  def paging(obj)
    obj.page(params[:page] || 1)
  end
end
