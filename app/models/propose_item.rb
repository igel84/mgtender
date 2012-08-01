class ProposeItem < ActiveRecord::Base
  attr_accessible :price, :propose_id, :tender_item_id

  belongs_to :propose
  belongs_to :tender_item
end
