#encoding: utf-8
class TenderRequestsController < ApplicationController
  before_filter :current_tender #, except: [:new]

  def create
    if params[:user_id]
      @tender.tender_requests << TenderRequest.new(user_id: params[:user_id], accepted_t: true)
    elsif params[:company_id]
      Company.find(params[:company_id]).personal.each do |user|
        @tender.tender_requests << TenderRequest.new(user_id: user.id, accepted_t: true)
      end
    elsif params[:tender_request]
      @tender.tender_requests << TenderRequest.new(company_name: params[:tender_request][:company_name], company_email: params[:tender_request][:company_email], accepted_t: true)
    end  

    @tender.save
    #@tender.tender_requests.last.send_mail
    redirect_to tender_tender_requests_path(tender_id: @tender.id)
  end

  def users_interest
    if params[:on] && params[:on] == 'true'
      if @tender.category == nil
        @message = 'сначала необходимо выбрать категорию тендера!'
      else
        @user_interest = Category.find(@tender.category.id).users_by_interest
      end
    end
    render 'index'
  end

  def accept
    @tender_request = TenderRequest.find(params[:id])
    @tender_request.accepted_t = true
    @tender_request.save
    redirect_to tender_tender_requests_path(tender_id: @tender.id)
  end

  def destroy
    TenderRequest.find(params[:id]).destroy
    redirect_to tender_tender_requests_path(tender_id: @tender.id)
  end

  private
    def current_tender
      @tender = Tender.find(params[:tender_id])         
    end
end