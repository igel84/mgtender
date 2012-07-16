#encoding: utf-8
class User < ActiveRecord::Base
  authenticates_with_sorcery!

  belongs_to :company #, :inverse_of => :users #, class_name: 'Company', foreign_key: "company_id"  
  #attr_accessible  #:company, :company_attributes, 
  #attr_writer :company, :company_id
  #has_one :company
  #accepts_nested_attributes_for :company
  
  has_and_belongs_to_many :categories
  attr_accessible :category_ids
  has_attached_file :photo, :styles => { :thumb=> ["100x100", :jpg] }


  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :fname, :nname, :phone, :photo, :company_id
  
  #validates_presence_of :company_id, message: "необходимо выбрать компанию, либо зарегистрировать новую"  
  #validates_associated :company
  #validates_associated :category_ids

  validates_presence_of :email, :phone, :fname, :nname, :category_ids
  validates :password, presence: { on: :create }, confirmation: true
  
  #def category_ids=(ids)
  #  self.categories = []
  #  self.
  #  self.category_ids = ids.split(",")
  #end

end