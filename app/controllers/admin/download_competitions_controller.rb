class Admin::DownloadCompetitionsController < AdminController
  def show
    @competition = Competition.find(params[:id])

    Slides.new.delay.generate_monthly(@competition, current_user.email)

    flash[:notice] = 'You will be emailed when your download is ready'
    redirect_to admin_competition_path(@competition)
  end
end
