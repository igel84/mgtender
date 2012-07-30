#encoding: utf-8
class TenderItemsController < ApplicationController
  before_filter :current_tender #, except: [:new]

  def create
    @tender.tender_items << TenderItem.new(params[:tender_item])
    @tender.save
    redirect_to tender_tender_items_path(tender_id: @tender.id)
  end

  def destroy
    TenderItem.find(params[:id]).destroy
    redirect_to tender_tender_items_path(tender_id: @tender.id)
  end

  private
    def current_tender
      @tender = Tender.find(params[:tender_id])         
    end
end
