class NotifyMailer < ApplicationMailer
  def send_mail to_user, subject, cuerpo1, cuerpo2, enlace, clickaqui
    @cuerpo1 = cuerpo1
    @enlace = enlace
    @cuerpo2 = cuerpo2
    @clickaqui = clickaqui
    mail(to: to_user, subject: subject)
  end
 
end
