#encoding: utf-8
class TendersController < ApplicationController
  before_filter :init_collections, only: [:new, :edit]
  before_filter :current_tender #, except: [:new]

  def create
    if @tender.id
      @tender = Tender.create(params[:tender])
      @tender.user = current_user
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
      render :edit
    end
    #redirect_to tender_steps_path
  end  

  def index
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
