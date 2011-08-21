class Evaluation < ActiveRecord::Base
  belongs_to :gradeing_scale
  belongs_to :formula
  belongs_to :report_definition
end
