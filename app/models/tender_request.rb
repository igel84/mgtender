class TenderRequest < ActiveRecord::Base
  after_create :send_mail

  attr_accessible :accepted_p, :accepted_t, :tender_id, :user_id, :company_name, :company_email

  belongs_to :tender
  belongs_to :user

  private
    def send_mail
      if self.tender.status > 0
        if self.accepted_t == true
          email = (self.user.nil? == true ? self.company_email : self.user.email)
          UserMailer.send_request(email, self.tender).deliver
        else
          email = self.tender.user.email
          UserMailer.send_response(email, self.tender).deliver
        end
      end
    end
end
