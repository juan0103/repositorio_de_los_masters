class NotifyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify_mailer.send_mail.subject
  #
  def send_mail to_user, subject
    mail(to: to_user, subject: subject)
  end
end
