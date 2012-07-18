#encoding: utf-8
require 'rubygems'
require 'mysql2'
require 'active_record'
require 'net/smtp'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :database => 'avtolit_development',
  :username => 'root',
  :password => '',
  :host     => 'localhost')

class Firm < ActiveRecord::Base
end

f = Firm.create(user_id:1, name:'__новая фирма')

message = <<MESSAGE_END
From: Private Person <admin@mlip.ru>
To: A Test User <yulianavtolit@yandex.ru>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

Net::SMTP.start('smtp.locum.ru', 2525, 'smtp.locum.ru', 'sender@mlip.ru', 'qwer1234vcxz', :plain) do |smtp|
	smtp.send_message message, 'sender@mlip.ru', 'yulianavtolit@yandex.ru'
end	

#	'smtp.locum.ru', 
#	'sender@mlip.ru', 
#	'qwer1234vcxz',
#	:plain)  do |smtp|
  

#:openssl_verify_mode  => 'none',
#        :enable_starttls_auto => true, #works in ruby 1.8.7 and above
#        :address => 'smtp.locum.ru',
#        :port => 2525,
#        #:domain => 'smtp.locum.ru',
#        :authentication => :plain,
#        :user_name => 'sender@mlip.ru',
#        :password => 'qwer1234vcxz'#,