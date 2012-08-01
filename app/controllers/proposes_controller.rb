#encoding: utf-8
class ProposesController < ApplicationController
  before_filter :current_tender, except: [:self_active, :self_arhive]

  def new
    unless @tender.can_propose?(current_user)
      @tender.send_request(current_user)
      flash[:message] = 'Заявка на участие в тендере отправлена'
      redirect_to @tender
    end
  end

  def create
    @propose = Propose.new(params[:propose])
    @propose.tender_id = @tender.id
    @propose.tender_iteration_id = @tender.tender_iterations.size
    @propose.user_id = current_user.id
    
    if params[:propose_item_id]
      if params[:propose_item_id].split(',').size > 0
        params[:propose_item_id].split(',').each_with_index do |item_id, index|
          @propose.propose_items << ProposeItem.new(tender_item_id: item_id, price: params[:propose_item_price].split(',')[index])
        end
      else
        @propose.propose_items << ProposeItem.new(tender_item_id: params[:propose_item_id], price: params[:propose_item_price].to_d)
      end
    end

    @propose.save
    redirect_to @tender
  end  

  def edit
    @propose = Propose.find(params[:id])
  end

  def update
    @propose = Propose.find(params[:id])
    @propose.update_attributes(params[:propose])
    #@propose.tender_id = @tender.id
    #@propose.tender_iteration_id = @tender.tender_iterations.size
    #@propose.user_id = current_user.id
    
    if params[:propose_item_id]
      if params[:propose_item_id].split(',').size > 0
        params[:propose_item_id].split(',').each_with_index do |item_id, index|
          item = ProposeItem.where(tender_item_id: item_id, propose_id: @propose.id).first
          item.price = params[:propose_item_price].split(',')[index]
          item.save
        end
      else
        item = ProposeItem.where(tender_item_id: item_id, propose_id: @propose.id).first
        item.price = params[:propose_item_price]
        item.save
      end
    end

    @propose.save
    redirect_to self_active_proposes_path
  end  

  def index
    @proposes = @tender.actual_proposes #Propose.order_by_summ
  end

  def self_active
    @tenders = current_user.request_tenders(1)
    #@tenders = Tender.where(user_id: current_user.id, status: 0..1)
  end

  def self_arhive
    @tenders = current_user.request_tenders(2)
  end

  def start
    @tender.start
    flash[:message] = 'Тендер активен, письма с приглашениями в участии разосланы пользователям'
    redirect_to status_tender_path(@tender)
  end

  def next_step
    @tender.next_step
    redirect_to @tender
  end

  private
    def current_tender
      @tender = Tender.find(params[:tender_id])        
      #session[:tender_id] == nil ? @tender = Tender.new : @tender = Tender.find(session[:tender_id])      
    end

end
