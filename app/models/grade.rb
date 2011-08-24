class Grade < ActiveRecord::Base
  default_scope :order => 'value DESC'
  belongs_to :grading_scale
end
