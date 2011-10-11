class Evaluation < ActiveRecord::Base
  belongs_to :grading_scale
  belongs_to :formula
  belongs_to :report_definition
  accepts_nested_attributes_for :grading_scale,:formula, :allow_destroy => true

  def evaluate(project, datetime)
    result = formula.evaluate_by_project_datetime(project,datetime)
    result[:grade] = grading_scale.grade result[:value].to_f unless result[:value] == ""
    result
  end
end
