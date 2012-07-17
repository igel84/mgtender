#encoding: utf-8
class TenderType < ActiveRecord::Base
  attr_accessible :info, :is_iteration, :is_selling, :name

  has_many :tenders

  def is_name?(sym)
  	case sym
  		when :tender
  			if (self.name == 'Тендер (продажа)' || 
  				self.name == 'Тендер (покупка)' || 
  				self.name == 'Итерационный тендер (продажа)' ||
  				self.name == 'Итерационный тендер (покупка)')
  					
  				return true
  			else
  				return false
  			end
  		when :auction
  			if (self.name == 'Аукцион (продажа)' || 
  				self.name == 'Аукцион (покупка)' || 
  				self.name == 'Аукцион с фиксированным шагом (продажа)' ||
  				self.name == 'Аукцион с фиксированным шагом (покупка)')
  					
  				return true
  			else
  				return false
  			end
  		when :review
  			if (self.name == 'Предварительный сбор предложений (продажа)' || 
  				self.name == 'Предварительный сбор предложений (покупка)')
  					
  				return true
  			else
  				return false
  			end
  	end
  end
end
