class Download < ActionMailer::Base
  default from: 'mcc-webmaster@melbournephoto.org.au'

  def complete(email, path)
    @path = path
    mail to: email, subject: 'Your download is ready'
  end
end
