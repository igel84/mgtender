class TenderAttachmentsController < ApplicationController
	before_filter :check

	def destroy		
		@attach.destroy		
		redirect_to edit_tender_path(@tender)	
	end

	private
		def check
			if params[:id] == nil || 
				params[:tender_id] == nil ||
				(@tender = Tender.find(params[:tender_id])) == nil ||
				(@attach = TenderAttachment.find(params[:id])) == nil
				redirect_to :root
			end
		end
end