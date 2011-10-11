class GradingScale < ActiveRecord::Base
  has_many :grades
  accepts_nested_attributes_for :grades, :allow_destroy => true


  def grade (score)
    grades.sort{|a,b| b.value <=> a.value }.each do |g| 
      return g if score > g.value  
    end
    grades.last
  end
end
