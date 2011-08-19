class Metric < ActiveRecord::Base

  has_many :formula_items, :as => :item

  require 'SonarApi'
  require 'json'
  
  def self.sync
    current_metric_keys = all.map{|metric| metric.key}
    potential_new_metrics = JSON.parse(SonarApi.metrics)
    
    
    new_metrics = []
    potential_new_metrics.each do |potential_new_metric|
      new_metrics << filter_new_metrics(potential_new_metric) unless current_metric_keys.include? potential_new_metric['key']
    end 
    create new_metrics
  end
  
  def self.filter_new_metrics(params)
    column_names = columns.map(&:name)
    metric_attrs = {}
    params.each{|k,v| metric_attrs[k] = v if column_names.include?(k.to_s) }
    metric_attrs
  end

  
end
