class Report < ActiveRecord::Base
  has_many :formula_reports
  has_many :formulas, :through => :formula_reports
  has_many :project_reports
  has_many :projects, :through => :project_reports
end
