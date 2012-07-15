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
    @url  = "http://http://www.mgtender.ru/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
       :subject => "Сброс пароля для входа на сайт www.mgtender.ru")
  end
end
