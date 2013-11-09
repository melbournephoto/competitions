class CompetitionsController < ApplicationController
  def index
    @competitions = Competition.all
  end


  def show
    @competition = Competition.find(params[:id])
    @entries = Entry.where(competition: @competition, user: current_user)
  end
end
