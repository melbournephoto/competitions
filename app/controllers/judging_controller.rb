class JudgingController < ApplicationController
  before_filter :authenticate_judge!

  layout 'judging'

  private
  def current_competition
    @current_competition || Competition.find_by_id(session[:judging_competition_id])
  end

  def authenticate_judge!
    unless current_competition
      render action: 'not_logged_in'
    end
  end
end
