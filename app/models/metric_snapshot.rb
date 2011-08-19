class MetricSnapshot < ActiveRecord::Base
  belongs_to :project
  belongs_to :metric
end
