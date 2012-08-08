class NewsController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]

  def index
    @news = News.all
  end

  def show
    @new = News.find(params[:id])
  end

end
