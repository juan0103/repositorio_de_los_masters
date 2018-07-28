class NotifyMailer < ApplicationMailer
  def send_mail to_user, subject, cuerpo
    @greeting = cuerpo
    mail(to: to_user, subject: subject)
  end
end
