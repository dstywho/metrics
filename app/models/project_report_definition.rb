class ProjectReportDefinition < ActiveRecord::Base
  belongs_to :project
  belongs_to :report
end
