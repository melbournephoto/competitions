class Admin::CompetitionSeriesController < AdminController
  def index
    @competition_series = CompetitionSeries.all
  end

  def show
    @competition_series = CompetitionSeries.find(params[:id])
  end
end
