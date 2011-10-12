class Project < ActiveRecord::Base
  require 'open-uri'
  require 'base64'
  require 'json'
  
  has_many :metric_snapshots
  
  def self.sync
    current_project_keys = all.map{|p| p.key}
    potential_new_projs = JSON.parse(SonarApi.resources)
    
    potential_new_projs.each do |new_proj|
      create_from_json(new_proj) unless current_project_keys.include? new_proj['key']
    end 
  end
  
  def self.create_from_json(params)
    column_names = columns.map(&:name)
    metric_attrs = {}
    params.each{|k,v| metric_attrs[k] = v if column_names.include?(k.to_s) && k != :id}
    create(metric_attrs)
  end

  def sonar_data(metrics, options, &callback)
    sonar_data = JSON.parse(SonarApi.timemachine(key,metrics.map(&:key),options))[0]
    metrics = sonar_data['cols'].map{|c| metrics.find{|m| m.key == c['metric'] }}
    sonar_data['cells'].each do |cell|
      cell['v'].each_with_index do |val,i|
        callback.call(metrics[i],val,Time.parse(cell['d'])) 
      end
    end
  end
  

  #SLOW
  #metrics are array of Metric
  def sync_snapshots(metrics, from_datetime=nil, to_datetime=nil)
    current_snaps = metric_snapshots.where("metric_id in (?)",metrics.map(&:id))
    current_snaps = current_snaps.where("datetime > ?", from_datetime) unless from_datetime.nil?
    current_snaps = current_snaps.where("datetime < ?", to_datetime) unless to_datetime.nil?
    
    options = {}
    options[:fromDateTime] = from_datetime.iso8601 if from_datetime
    options[:toDateTime] = to_datetime.iso8601 if to_datetime

    sonar_data(metrics,options) do |metric,value,datetime|
      matching_snapshot = current_snaps.find{|s|s.datetime == datetime && s.metric == metric}
      if( matching_snapshot.nil? )
          MetricSnapshot.create(:metric => metric, :project => self, :value =>value, :datetime => datetime ) 
      else
          matching_snapshot.updated_at = Time.now
          matching_snapshot.save
      end 
    end
  end


  #don't fetch if missing
  def current_snapshots(metrics=[], datetime=nil)
    datetime ||= Time.now
    snapshots = closest_snapshots(metrics,datetime)
    snapshots.select{|s| (! s.nil?) }
  end

  #possibly SLOW
  def snapshots(metrics=[], datetime=nil)
    datetime ||= Time.now
    #todo improve this with better query
    snapshots = closest_snapshots(metrics,datetime)
    if MetricSnapshot.stale? snapshots
      sync_snapshots(metrics,datetime - 1.day,datetime) 
      snapshots = closest_snapshots(metrics,datetime)
      #MetricSnapshot.update_timestamps(snapshots)
    end
    snapshots.select{|s| (! s.nil?) }
  end

  def closest_snapshots(metrics, datetime)
    snapshots = []
    metrics.each do |metric|
      snapshots << metric_snapshots.where("metric_id = ? and datetime < ?", metric, datetime).order("datetime desc").first
    end
    snapshots
  end

end
