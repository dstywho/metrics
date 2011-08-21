class GradingScale < ActiveRecord::Base
  has_many :grades
  accepts_nested_attributes_for :grades, :allow_destroy => true
end
