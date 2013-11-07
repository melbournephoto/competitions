class UsersController < ApplicationController
  before_filter :require_admin, except: :sign_out
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
