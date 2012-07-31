class TenderRequest < ActiveRecord::Base
  attr_accessible :accepted_p, :accepted_t, :tender_id, :user_id, :company_name, :company_email

  belongs_to :tender
  belongs_to :user

  def after_create(model)
    if model.tender.status > 0
      email = model.user.nil? == true ? model.company_email : model.user.email
      UserMailer.send_request(email, model.tender, nil)
    end
  end

end
