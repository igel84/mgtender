class TenderIteration < ActiveRecord::Base
  attr_accessible :end_at, :is_ended, :start_at, :tender_id

  belongs_to :tender
  
end
