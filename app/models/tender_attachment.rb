class TenderAttachment < ActiveRecord::Base
  has_attached_file :attach
  belongs_to :tender

  attr_accessible :attach_content_type, :attach_file_name, :attach_file_size, :attach_updated_at, :tender_id, :attach
  
end
