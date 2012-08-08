#encoding: utf-8
class SessionsController < ApplicationController
  skip_before_filter :require_login , except: :destroy

  def new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      redirect_back_or_to root_url, :notice => "Вы успешно вошли в систему"
    else
      flash.now.alert = "Логин или пароль указаны не верно!"
      render 'new'
    end
  end

  def destroy
    #logout
    if logged_in?
          before_logout!(current_user)
          reset_session
          @current_user = nil
          after_logout! if current_user
        end
    redirect_to root_url, :notice => "Вы успешно покинули систему"
  end
end