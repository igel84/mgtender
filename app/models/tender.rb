#encoding: utf-8
class Tender < ActiveRecord::Base
  require 'net/smtp'

  attr_accessible :category_id, :closed, :end_at, :name, :note, :start_at, :status, :step, :summ, :tender_type_id, :user_id, :iteration_count, :wicked
  belongs_to :user
  belongs_to :tender_type
  belongs_to :category

  has_many :tender_attachments
  has_many :tender_requests
  has_many :tender_items
  has_many :tender_iterations
  has_many :proposes
  has_one :winner

  scope :visibles, where(:visible => true)
 
  validate :check_tender, :if => :body?

  def body?
    wicked == 'body'
  end

  def start_body
    self.wicked = 'body'
    self.save
  end
  
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
      UserMailer.send_request(email, self).deliver
    end
  end

  def next_step(winner_propose = nil)
    #если итерационный завершаем итерацию
    if self.tender_type.is_iteration == true && self.tender_type.is_name?(:auction) == false
      last_iteration = self.tender_iterations.last
      last_iteration.end_at = Time.now
      last_iteration.is_ended = true
      last_iteration.save
      #если должна быть еще итерация, создаем новую
      if self.iteration_count > self.tender_iterations.size
        self.tender_iterations << TenderIteration.new(start_at: Time.now)
      #иначе завершаем тендер
      else        
        self.status += 1 if self.status != 3 #&& self.tender_type.is_name?(:preview) == false
        self.end_at = Time.now
      end      
    else
      self.status += 1 if self.status != 3 #&& self.tender_type.is_name?(:preview) == false
      self.end_at = Time.now
    end
    self.winner = Winner.new(propose_id: winner_propose.id) unless winner_propose.nil?
    self.save
  end

  def has_user_proposes?(user)
    self.last_propose(user) != nil
  end

  def last_propose(user)
    Propose.where('user_id=? AND tender_id=?', user.id, self.id).last
  end

  def can_propose?(user)
    TenderRequest.where('user_id=? AND tender_id=? AND accepted_t=?', user.id, self.id, true).first != nil
  end

  def send_request(current_user)
    TenderRequest.create(tender_id: self.id, user_id: current_user.id, accepted_p: true, accepted_t: false)
  end

  def actual_proposes
    Propose.where('tender_id=?', self.id)
  end

  def members
    User.joins(:proposes).where('proposes.tender_id=?', self)
  end

  protected
    def check_tender #, on: :update
      if self.category_id.nil? || self.end_at.nil? || self.name.nil? || self.note.nil? || self.start_at.nil? || self.summ.nil?
        self.errors.add(:presence, 'все поля должны быть заполнены')
      end
      if start_at && end_at && (start_at > end_at || start_at == end_at)
        self.errors.add(:date, 'дата запуска тендера должна быть больше даты окончания')
      end
      if summ && (summ == 0 || summ < 0)
        self.errors.add(:summ, 'стоимость должна быть больше 0')
      end
    end
end
