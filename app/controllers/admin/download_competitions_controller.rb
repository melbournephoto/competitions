class Admin::DownloadCompetitionsController < AdminController
  def show
    @competition = Competition.find(params[:id])

    if params.include?('titled')
      Slides.new.delay.generate_titled_slides(@competition, current_user.email)
    else
      Slides.new.delay.generate_monthly(@competition, current_user.email)
    end

    flash[:notice] = 'You will be emailed when your download is ready'
    redirect_to admin_competition_path(@competition)
  end
end
