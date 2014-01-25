class Admin::EmailJudgingLinksController < AdminController
  before_filter :set_competition

  def new
    @email_judging_link = EmailJudgingLink.new
  end

  def create
    @email_judging_link = EmailJudgingLink.new
    @email_judging_link.email = params[:email_judging_link][:email]
    if @email_judging_link.valid?
      JudgingMailer.links(@email_judging_link.email, @competition).deliver
      redirect_to admin_competition_path(@competition), notice: 'Judging link sent to ' + @email_judging_link.email
    else
      render action: 'new'
    end
  end

  private
  def set_competition
    @competition = Competition.find(params[:competition_id])
  end
end
