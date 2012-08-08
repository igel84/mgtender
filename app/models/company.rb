#encoding: utf-8
class Company < ActiveRecord::Base
  #validates :full_name, :presence => true  
  #validates :inn, :presence => true

  attr_accessible :name, :general_phone, :inn, :is_nds, :owner_form_id, :sphere_id, :master_id, :master, :logo
  
  has_many :users#, :inverse_of => :company
  accepts_nested_attributes_for :users

  belongs_to :master, class_name: 'User', foreign_key: "master_id"
  #accepts_nested_attributes_for :master

  belongs_to :owner_form 
  belongs_to :sphere  

  has_attached_file :logo, :styles => { :thumb=> ["100x100", :jpg] }, :whiny => false

  validate :check_logo, :if => lambda { logo.dirty? }
  #validate :check_logo, on: :create
  #validate :check_logo, on: :update
  
  validates_presence_of :name, :general_phone, :owner_form_id, :sphere_id
  validates_presence_of :inn, :message => "укажите ИНН"
  validates_uniqueness_of :inn, :message => "компания с данным ИНН уже зарегистрирована"

  def personal
    users_return = []
    #users_return << User.first
    users_return += self.users
    users_return << self.master if self.master
    return users_return.uniq
  end

  protected
    def check_logo
      if self.logo && self.logo.queued_for_write[:original] && (self.logo.content_type == 'image/jpeg' || self.logo.content_type == 'image/png')
        dimensions = Paperclip::Geometry.from_file(self.logo.queued_for_write[:original])
        fsize = self.logo.size
        fformat = self.logo.content_type
        self.errors.add(:logo, "размер изображения не должен превышать 100px") if dimensions.width > 100 || dimensions.height > 100
        self.errors.add(:logo, "размер файла не должен превышать 100кБ") if fsize > 100.kilobytes
        self.errors.add(:logo, "формат файла должен быть: jpg, jpeg или png") if (fformat != 'image/jpeg' && fformat != 'image/png')
      elsif self.logo && self.logo.queued_for_write[:original] && (self.logo.content_type != 'image/jpeg' || self.logo.content_type != 'image/png')
        self.errors.add(:logo, "формат файла должен быть: jpg, jpeg или png") if (fformat != 'image/jpeg' && fformat != 'image/png')
      end
  end

end
