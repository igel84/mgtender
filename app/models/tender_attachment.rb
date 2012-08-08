#encoding: utf-8
class TenderAttachment < ActiveRecord::Base
  has_attached_file :attach
  belongs_to :tender

  attr_accessible :attach_content_type, :attach_file_name, :attach_file_size, :attach_updated_at, :tender_id, :attach
  validate :check_attach, :if => lambda { attach.dirty? }

  protected
    def check_attach
      if (self.attach && 
          (self.attach.content_type == 'application/x-rar' || 
          self.attach.content_type == 'application/msword' ||
          self.attach.content_type == 'application/zip' ||            
          self.attach.content_type == 'application/vnd.ms-excel' || 
          self.attach.content_type ==  'application/pdf'))
        
        fsize = self.attach.size || self.errors.add(:attach, "sdfdf")
        fformat = self.attach.content_type || self.errors.add(:attach, "sdfdf")
        self.errors.add(:attach, "размер файла не должен превышать #{NumberValue.find_by_name('attach').count}Mб") if fsize && (fsize > NumberValue.find_by_name('attach').count.megabytes)
        self.errors.add(:attach, "формат файла должен быть: jpg, jpeg или png") if fformat && (fformat != 'application/x-rar' && fformat != 'application/zip' && fformat != 'application/msword' && fformat != 'application/vnd.ms-excel' && fformat != 'application/pdf')
      
      elsif self.attach && self.attach.queued_for_write[:original] && (self.attach.content_type != 'application/x-rar' || self.attach.content_type != 'application/zip' || self.attach.content_type != 'application/msword' || self.attach.content_type != 'application/vnd.ms-excel')
        self.errors.add(:attach, "формат файла должен быть: jpg, jpeg или png")
      end
    end 
end
