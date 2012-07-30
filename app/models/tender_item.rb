class TenderItem < ActiveRecord::Base
  attr_accessible :count, :name, :price, :tender_id

  belongs_to :tender
end
