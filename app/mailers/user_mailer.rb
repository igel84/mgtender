#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "sender@mlip.ru"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activation_needed_email.subject
  #
  def activation_needed_email(user)
    @user = user
    @url  = "http://www.mgtender.ru/users/#{user.activation_token}/activate"
    mail(:to => user.email,
         :subject => "Добро пожаловать на сайт www.mgtender.ru")
  end
      
  def activation_success_email(user)
    @user = user
    @url  = "http://http://www.mgtender.ru/login"
    mail(:to => user.email,
         :subject => "Профиль на сайте www.mgtender.ru успешно активирован")
  end

  def reset_password_email(user)
    @user = user
    @url  = "http://www.mgtender.ru/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
       :subject => "Сброс пароля для входа на сайт www.mgtender.ru")
  end

  def send_request(email, tender, secret = nil)
    @url = "http://www.mgtender.ru/tenders/#{tender.id}"
    @secret = secret

    mail(to: email, subject: 'Вас приглашают участвовать в тендере')  
  end

  def send_response(email, tender)
    @url = "http://www.mgtender.ru/tenders/#{tender.id}/tender_requests"
    mail(to: email, subject: 'Разрешение на участие в тендере')  
  end

  def send_finish_tender(email, tender, winner = nil)
    #@url = "http://www.mgtender.ru/tenders/#{tender.id}/tender_requests"
    @tender = tender
    @winner = winner if winner
    mail(to: email, subject: 'Тендер окончен')  
  end

end
