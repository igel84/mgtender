class Winner < ActiveRecord::Base
  attr_accessible :propose_id, :tender_id

  belongs_to :tender
  belongs_to :propose
  
end
