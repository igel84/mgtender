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

  has_attached_file :logo, :styles => { :thumb=> ["100x100", :jpg] }

  validates_presence_of :name, :general_phone, :owner_form_id, :sphere_id
  validates_presence_of :inn, :message => "укажите ИНН"
  validates_uniqueness_of :inn, :message => "компания с данным ИНН уже зарегистрирована"

end
