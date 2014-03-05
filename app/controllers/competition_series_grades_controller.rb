class CompetitionSeriesGradesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @competition = Competition.find_by_id(params[:competition_id])
    @competition_series_grade = current_user.competition_series_grades.new(competition_series_grade_params)
    @competition_series = @competition_series_grade.competition_series
    if @competition_series_grade.save
      if @competition
        redirect_to new_competition_entry_path(@competition)
      else
        redirect_to root_path, notice: 'Your grade has been saved'
      end
    else
      render action: 'edit'
    end
  end

  def edit
    @competition_series = CompetitionSeries.find(params[:id])
    @competition = Competition.find_by_id(params[:competition_id])
    if @competition_series.grades.count == 1
      CompetitionSeriesGrade.find_or_create_by!(user: current_user, competition_series: @competition_series, grade: @competition_series.grades.first)
      redirect_to new_competition_entry_path(@competition)
    else
      @competition_series_grade = CompetitionSeriesGrade.find_or_initialize_by(user: current_user, competition_series: @competition_series)
    end
  end

  private
  def competition_series_grade_params
    params.require(:competition_series_grade).permit(:grade_id, :competition_series_id)
  end
end
