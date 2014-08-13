class Admin::GradesController < AdminController
  def new
    @grade = competition_series.grades.build
  end

  def create
    @grade = competition_series.grades.build(grade_params)
    if @grade.save
      redirect_to admin_competition_series_path(competition_series)
    else
      render action: 'new'
    end
  end

  private

  def competition_series
    @competition_series ||= CompetitionSeries.find(params[:competition_series_id])
  end

  def grade_params
    params.require(:grade).permit(:title)
  end
end
