class JudgingMailer < ActionMailer::Base
  default from: "mcc-edi-comp@melbournephoto.org.au"

  def links(recipient, competition)
    @competition = competition
    mail to: recipient, subject: 'Judging link for ' + competition.title
  end
end
