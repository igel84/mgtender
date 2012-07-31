class Tender < ActiveRecord::Base
  require 'net/smtp'

  attr_accessible :category_id, :closed, :end_at, :name, :note, :start_at, :status, :step, :summ, :tender_type_id, :user_id, :iteration_count
  belongs_to :user
  belongs_to :tender_type
  belongs_to :category

  has_many :tender_attachments
  has_many :tender_requests
  has_many :tender_items

  scope :visibles, where(:visible => true)
    

  def has_error?
    result = false
    if (self.category.nil? || self.end_at.nil? || self.name.blank? || self.note.blank? || self.summ.nil?)
      result = true
    end
    return result
  end

  def start
    self.status = 1
    self.start_at = Time.now
    self.save

    self.tender_requests.each do |request|
      email = request.user.nil? == true ? request.company_email : request.user.email
      #url = 
      UserMailer.send_request(email, self, nil)
    end
  end

end
