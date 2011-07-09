class Metric < ActiveRecord::Base

  require 'open-uri'
  require 'base64'
  require 'json'
  
  SONAR_URL = "http://nemo.sonarsource.org/" 
  
  def self.sync
    current_metric_keys = all.map{|metric| metric.key}
    # puts SONAR_URL + "api/metrics?format=json"
    potential_new_metrics = JSON.parse(open(SONAR_URL + "api/metrics?format=json").readlines[0])
    
    puts "POT SZE #{potential_new_metrics.size}"
    potential_new_metrics.each do |potential_new_metric|
      create_from_json(potential_new_metric) unless current_metric_keys.include? potential_new_metric[:key]
    end 
  end
  
  def self.create_from_json(params)
    puts "ZZZZZZZZZZZZZZZZZZZ"
    column_names = columns.map(&:name)
    puts column_names
    metric_attrs = {}
    params.each{|k,v| metric_attrs[k] = v if column_names.include?(k.to_s) }
    puts "XXXX #{metric_attrs}"
    create(metric_attrs)
  end
  
end
