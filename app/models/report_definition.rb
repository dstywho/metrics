class ReportDefinition < ActiveRecord::Base
  has_many :project_report_definitions
  has_many :projects, :through => :project_report_definitions
  has_many :evaluations
  accepts_nested_attributes_for :projects,:project_report_definitions, :allow_destroy => true
end
