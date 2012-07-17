#encoding: utf-8
class TendersController < ApplicationController
  before_filter :init_collections, only: [:new]
  before_filter :current_tender #, except: [:new]

  def create
    @tender = Tender.create(params[:tender])
    @tender.user = current_user
    if @tender.save
      session[:tender_id] = @tender.id
      #if @tender.tender_type.name == 'Аукцион (продажа)' 
      redirect_to tender_steps_path
    else
      render :new
    end
  end  

  def update
    @tender.attributes = params[:tender]
    @tender.save
    redirect_to tender_steps_path
  end  

  def index
  end

  private
    def init_collections
      @tender_types = TenderType.all
    end

    def current_tender
      session[:tender_id] == nil ? @tender = Tender.new : @tender = Tender.find(session[:tender_id])      
    end

end
