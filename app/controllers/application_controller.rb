class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  private
  def require_admin
    unless current_user.admin?
      redirect_to root_path, notice: "Action not permitted"
    end
  end
end
