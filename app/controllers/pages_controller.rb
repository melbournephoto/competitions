class PagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def show
    valid_pages = %w[help]
    if valid_pages.include? params[:id]
      render action: params[:id]
    else
      redirect_to root_path
    end
  end
end
