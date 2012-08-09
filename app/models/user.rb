#encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :fname, :nname, :phone, :photo, :company_id, :admin, :activation_state, :username
  
  has_many :excels
  has_many :tenders
  has_many :tender_requests
  has_many :proposes
  belongs_to :company #, :inverse_of => :users #, class_name: 'Company', foreign_key: "company_id"  
  #attr_accessible  #:company, :company_attributes, 
  #attr_writer :company, :company_id
  #has_one :company
  #accepts_nested_attributes_for :company
  
  has_and_belongs_to_many :categories
  attr_accessible :category_ids

  has_attached_file :photo, :styles => { :thumb=> ["100x100", :jpg] }, :whiny => false
  
  #attr_protected :photo_file_name, :photo_content_type, :photo_size

  #validates_attachment :photo, :content_type => { :content_type => "image/jpg" }, :size => { :in => 0..10.kilobytes }

  validate :check_photo, :if => lambda { photo.dirty? }
  #validates_attachment_presence :photo unless :photo
  #validates_attachment_size :photo, :less_than => 100.kilobytes, :if => lambda { photo.dirty? } #, :unless => Proc.new { |m| m[:photo].nil? } 
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']  unless :photo#, message: 'формат файла должен быть: jpg, jpeg или png' 

  #validate :check_photo, if: "self.new_record?"
  #validate :check_photo, on: :create
  #validate :check_photo, on: :update
  
  #validates_presence_of :company_id, message: "необходимо выбрать компанию, либо зарегистрировать новую"  
  #validates_associated :company
  #validates_associated :category_ids

  validates_presence_of :email, :phone, :fname, :nname, :category_ids
  validates_presence_of :password, on: :create, message: 'пароль не может быть пустым'
  validates_confirmation_of :password, message: 'пароль не совпадает с подтврерждением'  #true
  validates_format_of :password, with: /^[a-zA-Z0-9_]*[a-zA-Z][a-zA-Z0-9_]*$/, message: 'пароль должен состоять из цифр и букв', if: "!password.blank?"
  validates_length_of :password, :minimum => 8, message: 'пароль не должен быть короче 8 символов', if: "!password.blank?"
  
  def to_s
    self.fname
  end

  def role? (str)
    case str
      when :admin
        self.admin == true
      else
        false
      end
  end

  def request_tenders(status)
    Tender.joins(:tender_requests).where('tender_requests.user_id=? AND status=?', self.id, status)
  end
  #def category_ids=(ids)
  #  self.categories = []
  #  self.
  #  self.category_ids = ids.split(",")
  #end

  authenticates_with_sorcery!

  protected
    def check_photo
      if self.photo && self.photo.queued_for_write[:original] && (self.photo.content_type == 'image/jpeg' || self.photo.content_type == 'image/png')
        dimensions = Paperclip::Geometry.from_file(self.photo.queued_for_write[:original])
        fsize = self.photo.size || self.errors.add(:photo, "sdfdf")
        fformat = self.photo.content_type || self.errors.add(:photo, "sdfdf")
        self.errors.add(:photo, "размер изображения не должен превышать 100px") if dimensions.width > 100 || dimensions.height > 100
        self.errors.add(:photo, "размер файла не должен превышать 100кБ") if fsize && (fsize > 100.kilobytes)
        self.errors.add(:photo, "формат файла должен быть: jpg, jpeg или png") if fformat && (fformat != 'image/jpeg' && fformat != 'image/png')
      elsif self.photo && self.photo.queued_for_write[:original] && (self.photo.content_type != 'image/jpeg' || self.photo.content_type != 'image/png')
        self.errors.add(:photo, "формат файла должен быть: jpg, jpeg или png") if (fformat != 'image/jpeg' && fformat != 'image/png')
      end
    end 

end