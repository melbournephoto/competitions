class JudgingMailer < ActionMailer::Base
  default from: "mcc-webmaster@melbournephoto.org.au"

  def links(recipient, competition)
    @competition = competition
    mail to: recipient, subject: 'Judging link for ' + competition.title
  end
end
