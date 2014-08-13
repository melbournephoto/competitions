class Admin::CompetitionSeriesController < AdminController
  def index
    @competition_series = CompetitionSeries.all
  end

  def show
    @competition_series = CompetitionSeries.find(params[:id])
  end

  def new
    @competition_series = CompetitionSeries.new
  end

  def create
    @competition_series = CompetitionSeries.new(competition_series_params)
    if @competition_series.save
      redirect_to admin_competition_series_path(@competition_series)
    else
      render action: 'new'
    end
  end

  private

  def competition_series_params
    params.require(:competition_series).permit(:title)
  end
end
