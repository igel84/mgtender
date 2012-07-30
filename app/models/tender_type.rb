#encoding: utf-8
class TenderType < ActiveRecord::Base
  attr_accessible :info, :is_iteration, :is_selling, :name

  has_many :tenders

  def self.convert_iteration(type, val)
    TenderType.where(name:'auction').where(is_selling:type.is_selling).where(is_iteration:(val == 'true')).first
  end

  def near?(type)
    if self.name == type.name && self.is_selling == type.is_selling
      true
    else
      false
    end
  end

  def name_ru
    result = case self.name
      when 'tender'
        "Тендер"
      when 'auction'
        "Аукцион"
      when 'review'
        "Предварительный сбор предложений"
      else
        ""
    end
    result += (self.is_selling == true ? ' (Продажа)' : ' (Покупка)')       
    return result
  end

  def short_name_ru
    result = case self.name
      when 'tender'
        "Тендер"
      when 'auction'
        "Аукцион"
      when 'review'
        "Предварительный сбор предложений"
      else
        ""
    end
    return result
  end

  def is_name?(sym)
  	case sym
  		when :tender
  			if (self.name == 'tender')
  					
  				return true
  			else
  				return false
  			end
  		when :auction
  			if (self.name == 'auction')
  					
  				return true
  			else
  				return false
  			end
  		when :review
  			if (self.name == 'review')
  					
  				return true
  			else
  				return false
  			end
  	end
  end
end
