class InvitesController < ApplicationController
  before_filter :is_admin?

  def new; end

  def create
    User.invite!(email: params[:invite][:email])
    redirect_to :root, notice: 'Invite send successfully'
  end

  private

  def is_admin?
    redirect_to(:root) unless current_user.is_admin
  end
end
