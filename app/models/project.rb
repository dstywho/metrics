class Project < ActiveRecord::Base
  require 'open-uri'
  require 'base64'
  require 'json'
  
  def self.sync
    current_metric_keys = all.map{|metric| metric.key}
    potential_new_metrics = Json.parse(open(Metric::SONAR_URL + "api/resources?format=json"))
    
    potential_new_metrics.each do |potential_new_metric|
      create_from_json(potential_new_metric) unless current_metric_keys.include? potential_new_metric[:key]
    end 
  end
  
  def self.create_from_json(params)
    metric_attrs = params.select{|k,v| columns.include?(k) && k != :id}
    create(metric_attrs)
  end
end
