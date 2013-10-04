class ApplicationController < ActionController::Base
  protect_from_forgery

protected
  def paging(obj, per_page = Kaminari.config.config.default_per_page)
    obj.page(params[:page] || 1).per(per_page)
  end
end
