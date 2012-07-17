#encoding: utf-8
class TenderStepsController < ApplicationController
  include Wicked::Wizard
  before_filter :current_tender
  
  steps :iteration, :info
  
  def show
    case step
      when :iteration
        skip_step      
    end
    render_wizard
  end

  def update
    @tender.attributes = params[:tender]
    render_wizard @tender
  end

  private
    def redirect_to_finish_wizard
      redirect_to tenders_url, notice: "Тендер успешно создан!"
    end

    def current_tender
      session[:tender_id] == nil ? @tender = Tender.new : @tender = Tender.find(session[:tender_id])      
    end

end
