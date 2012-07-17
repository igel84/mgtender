class Tender < ActiveRecord::Base
  attr_accessible :category_id, :closed, :end_at, :name, :note, :start_at, :status, :step, :summ, :tender_type_id, :user_id, :iteration_count

  belongs_to :user
  belongs_to :tender_type
end
