class HomesController < ApplicationController
	skip_before_filter :require_login, :only => [:about, :index]
end
