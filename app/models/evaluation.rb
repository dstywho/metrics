class Evaluation < ActiveRecord::Base
  belongs_to :grading_scale
  belongs_to :formula
  belongs_to :report_definition
  accepts_nested_attributes_for :grading_scale,:formula, :allow_destroy => true
end
