class CompetitionSeriesGradesController < ApplicationController
	def create
		@competition_series_grade = current_user.competition_series_grades.new(competition_series_grade_params)

		if @competition_series_grade.save
			redirect_to root_path, notice: 'Your grade has been saved'
		else
			render action: 'edit'
			throw @competition_series_grade.errors.to_a.join(' ')
		end
	end

	def edit
		@competition_series_grade = CompetitionSeriesGrade.find_or_initialize_by(user: current_user, competition_series_id: params[:id])
	end

	private
	def competition_series_grade_params
		params.require(:competition_series_grade).permit(:grade_id, :competition_series_id)
	end
end
