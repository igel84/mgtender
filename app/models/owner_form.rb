#encoding: utf-8
class OwnerForm < ActiveRecord::Base
  attr_accessible :is_nds, :name
  has_many :companies

  def full_name
  	self.name  + (self.is_nds == true ? ' (общая система налогооблажения)' : '')
  end
end
