class Formula < ActiveRecord::Base

  attr_accessor :formula
  has_many :formula_items
  
  
  def calculate(date)
    
    to_s   
  end

end
