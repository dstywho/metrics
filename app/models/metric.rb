class Metric < ActiveRecord::Base

  require 'open-uri'
  require 'base64'
  require 'json'
  
  SONAR_URL = "http://nemo.sonarsource.org/" 
  
  def self.sync
    current_metric_keys = all.map{|metric| metric.key}
    potential_new_metrics = JSON.parse(open(SONAR_URL + "api/metrics?format=json").readlines[0])
    
    potential_new_metrics.each do |potential_new_metric|
      create_from_json(potential_new_metric) unless current_metric_keys.include? potential_new_metric[:key]
    end 
  end
  
  def self.create_from_json(params)
    column_names = columns.map(&:name)
    metric_attrs = {}
    params.each{|k,v| metric_attrs[k] = v if column_names.include?(k.to_s) }
    create(metric_attrs)
  end
  
end
