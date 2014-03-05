class CompetitionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @open_competitions = Competition.open
    @enterred_competitions = Competition.entered_by(current_user)
  end


  def show
    @competition = Competition.find(params[:id])
    @entries = Entry.extant.where(competition: @competition, user: current_user)
  end
end
