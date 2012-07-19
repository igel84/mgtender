#encoding: utf-8
class TenderStepsController < Wicked::WizardController
  #include Wicked::Wizard
  before_filter :current_tender
  
  steps :iteration #, :info
  
  def show
    #case step
    #  when :iteration
    #    skip_step unless @tender.tender_type.is_name? :auction
    #end
    render_wizard
  end

  def update
    @tender.attributes = params[:tender]
    @tender.tender_type = TenderType.convert_iteration(@tender.tender_type, params[:is_iteration]) if (params[:is_iteration] == 'true' || params[:is_iteration] == 'false')
    @tender.save
    render_wizard @tender
  end

  private
    def redirect_to_finish_wizard
      session[:tender_id] = nil
      redirect_to edit_tender_path(@tender) #, notice: "Тендер успешно создан!"
    end

    def current_tender
      @tender_types = TenderType.all
      session[:tender_id] == nil ? @tender = Tender.new : @tender = Tender.find(session[:tender_id])      
    end

end
