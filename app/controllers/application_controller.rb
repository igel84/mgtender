#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login, :except => [:not_authenticated]

  private
  	def not_authenticated
    	redirect_to login_url, :alert => "Сначала необходимо войти в систему!"
  	end
end
