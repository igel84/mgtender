class Propose < ActiveRecord::Base
  attr_accessible :delay, :tender_iteration_id, :note, :num_of_trans, :tender_id, :user_id

  belongs_to :user
  belongs_to :tender_iteration
  belongs_to :tender

  has_many :propose_items

end
