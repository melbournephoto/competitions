class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

    @competition_series = []
    CompetitionSeries.all.each do |competition_series|
      user_grade = CompetitionSeriesGrade.find_by(competition_series: competition_series, user: @user).try(:grade)
      grades = competition_series.grades

      @competition_series << { user_grade: user_grade, grades: grades, competition_series: competition_series }
    end
  end

  def update
    @user = User.find(params[:id])

    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    # Fucking Devise
    user_params.delete :password if user_params.include?(:password) && user_params[:password].blank?
    user_params.delete :password_confirmation if user_params.include?(:password_confirmation) && user_params[:password_confirmation].blank?

    if params[:user][:competition_series]
      params[:user][:competition_series].each do |competition_series_id, grade_id|
        next unless grade_id
        csg = CompetitionSeriesGrade.find_or_create_by(user: @user, competition_series_id: competition_series_id)
        csg.grade_id = grade_id
        csg.save
      end
    end

    @user.update_attributes!(user_params)
    redirect_to admin_user_path(@user), notice: 'User has been updated'
  end
end
