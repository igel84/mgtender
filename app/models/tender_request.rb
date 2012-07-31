class TenderRequest < ActiveRecord::Base
  after_create :send_mail

  attr_accessible :accepted_p, :accepted_t, :tender_id, :user_id, :company_name, :company_email

  belongs_to :tender
  belongs_to :user

  private
    def send_mail
      if self.tender.status > 0
        email = self.user.nil? == true ? self.company_email : self.user.email
        UserMailer.send_request(email, self.tender, nil)
      end
    end
end
