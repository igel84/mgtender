#encoding: utf-8
class TendersController < ApplicationController
  before_filter :init_collections, only: [:new, :edit]
  before_filter :current_tender #, except: [:new]

  def new
    @tender = Tender.new(user_id: current_user.id)
  end

  def create
    if @tender.id
      @tender = Tender.new(params[:tender])
      @tender.user_id = current_user.id
    else
      @tender.attributes = params[:tender]
    end
    
    if @tender.save
      session[:tender_id] = @tender.id      
      if @tender.tender_type.is_name?(:auction)
        redirect_to tender_steps_path
      else
        redirect_to edit_tender_path(@tender)
      end
    else
      render :new
    end
  end  

  def edit
  end

  def update
    if params[:attach]
      @tender.tender_attachments << TenderAttachment.new(attach:params[:attach])
    end
    @tender.attributes = params[:tender]
    @tender.save
    if @tender.tender_type.is_name?(:auction) && params[:tender][:tender_type_id]
      session[:tender_id] = @tender.id
      redirect_to tender_steps_path
    else
      if params[:next_button]
        redirect_to tender_tender_requests_path(tender_id: @tender.id)
      else
        render :edit
      end
    end
    #redirect_to tender_steps_path
  end  

  def index
  end

  def self
    @tenders = current_user.tenders
  end

  private
    def init_collections
      @tender_types = TenderType.all
    end

    def current_tender
      params[:id] ==  nil ? @tender = Tender.new : @tender = Tender.find(params[:id])        
      #session[:tender_id] == nil ? @tender = Tender.new : @tender = Tender.find(session[:tender_id])      
    end

end
