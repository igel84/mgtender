class TenderRequest < ActiveRecord::Base
  attr_accessible :accepted_p, :accepted_t, :tender_id, :user_id, :company_name, :company_email

  belongs_to :tender
  belongs_to :user
end
