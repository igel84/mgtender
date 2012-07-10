class Company < ActiveRecord::Base
  validates :full_name, :presence => true  
  validates :inn, :presence => true

  attr_accessible :full_name, :general_phone, :inn, :is_nds, :logo_content_type, :logo_file_size, :owner_form_id, :sphere_id

  has_many :users
end
