class Grade < ActiveRecord::Base
  validates_presence_of :value
  validates_presence_of :name
  default_scope :order => 'value DESC'
  belongs_to :grading_scale

  def greather_than(num)
    value > num
  end
end
