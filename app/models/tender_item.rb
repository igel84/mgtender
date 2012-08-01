class TenderItem < ActiveRecord::Base
  attr_accessible :count, :name, :price, :tender_id

  belongs_to :tender
  has_many :propose_items

  def summ
    self.price * self.count
  end
end
