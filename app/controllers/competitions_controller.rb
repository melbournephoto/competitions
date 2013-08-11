class CompetitionsController < ApplicationController
  before_filter :require_admin, except: [:index, :show]
  def index
    @competitions = Competition.all
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = Competition.new(competition_params)
    if @competition.save
      redirect_to @competition, notice: 'Competition created'
    else
      render action: 'new'
    end
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def edit
    @competition = Competition.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:id])
    if @competition.update_attributes(competition_params)
      redirect_to @competition, notice: 'Competition updated'
    else
      render action: 'edit'
    end
  end

  private
  def competition_params
    params.require(:competition).permit(:title, :entries_open_at, :entries_close_at, :results_published_at, :notes)
  end
end
