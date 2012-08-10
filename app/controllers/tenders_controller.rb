#encoding: utf-8
class TendersController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]
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
    @tender.start_body
        
    if params[:attach]
      attach = TenderAttachment.new(attach:params[:attach])
      if attach.valid?          
        @tender.tender_attachments << attach
      else
        flash.now[:attach_error] = attach.errors[:attach].join(", ") if attach.errors[:attach].any?
      end
    end
    @tender.attributes = params[:tender]
    @tender.save
    if @tender.tender_type.is_name?(:auction) && params[:tender][:tender_type_id]
      session[:tender_id] = @tender.id
      redirect_to tender_steps_path
    else
      if params[:next_button]
        if @tender.valid?          
          redirect_to tender_tender_requests_path(tender_id: @tender.id)
        else
          flash.now[:presence_error] = @tender.errors[:presence].join(", ") if @tender.errors[:presence].any?
          flash.now[:date_error] = @tender.errors[:date].join(", ") if @tender.errors[:date].any?
          flash.now[:summ_error] = @tender.errors[:summ].join(", ") if @tender.errors[:summ].any?
          render :edit
        end
      else
        render :edit
      end
    end
    #redirect_to tender_steps_path
  end  

  def index
    @tenders = Tender.where(status: 1, closed: false).page params[:page]
  end

  def self_active
    @tenders = Tender.where(user_id: current_user.id, status: 0..1).page params[:page]
  end

  def self_arhive
    @tenders = Tender.where(user_id: current_user.id, status: 2..3).page params[:page]
  end

  def start
    @tender.start
    flash[:message] = 'Тендер активен, письма с приглашениями в участии разосланы пользователям'
    redirect_to status_tender_path(@tender)
  end

  def next_step
    @tender.next_step
    #if @tender.status == 2
    #  redirect_to tender_proposes_path(@tender)
    #else
      redirect_to @tender
    #end
  end

  def destroy
    Tender.find(params[:id]).destroy
    redirect_to tenders_path
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
