#encoding: utf-8
class Tender < ActiveRecord::Base
  require 'net/smtp'

  attr_accessible :category_id, :closed, :end_at, :name, :note, :start_at, :status, :step, :summ, :tender_type_id, :user_id, :iteration_count
  belongs_to :user
  belongs_to :tender_type
  belongs_to :category

  has_many :tender_attachments
  has_many :tender_requests
  has_many :tender_items
  has_many :tender_iterations

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

    if self.iteration_count > 1
      self.tender_type = TenderType.convert_iteration(self.tender_type, 'true')      
      self.tender_iterations << TenderIteration.new(start_at: Time.now)
    end
    self.start_at = Time.now
    self.save

    self.tender_requests.each do |request|
      email = (request.user.nil? == true ? request.company_email : request.user.email)
      UserMailer.send_request(email, self)
    end
  end

  def next_step
    #если итерационный завершаем итерацию
    if self.tender_type.is_iteration == true
      last_iteration = self.tender_iterations.last
      last_iteration.end_at = Time.now
      last_iteration.is_ended = true
      last_iteration.save
      #если должна быть еще итерация, создаем новую
      if self.iteration_count > self.tender_iterations.size
        self.tender_iterations << TenderIteration.new(start_at: Time.now)
      #иначе завершаем тендер
      else
        self.status = 2
        self.end_at = Time.now
      end      
    else
      self.status = 2
      self.end_at = Time.now
    end
    self.save
  end

end
