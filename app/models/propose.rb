class Propose < ActiveRecord::Base
  attr_accessible :delay, :tender_iteration_id, :note, :num_of_trans, :tender_id, :user_id

  belongs_to :user
  belongs_to :tender_iteration
  belongs_to :tender

  has_many :propose_items

  #scope :order_by_summ, joins(:propose_items).select('user_id, sum(propose_items.price) as total_prize').order('total_prize desc')

  def summ
    result = 0.0
    self.propose_items.each do |item|
      result += item.price
    end
    return result
  end

end
