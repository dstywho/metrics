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

  def evaluate_all(project, datetime, numMonths=10)
    numMonths = 10 if numMonths.nil?
    datetime ||= Time.now
    results = []
    (1..numMonths.to_i).each do |idx|
      dt = datetime - idx.months
      result = evaluate(project,dt)
      result[:datetime] = dt
      result[:date] = {:year => dt.year, :month => dt.month, :day => dt.day} 
      results << result
    end
    results
  end
end
