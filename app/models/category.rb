class Category < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :users
  has_many :tenders

  def users_by_interest
    users_return = []    
    users_return += self.users
    return users_return
  end
  
end
