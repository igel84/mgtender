class Sphere < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :name, :parent_id
  attr_protected :lft, :rgt

  has_many :companies
  accepts_nested_attributes_for :companies

  def names
  	result = ''
  	self.self_and_ancestors.each do |obj|
  		result += obj.name
  	end	
  	return result
  end

end
