class MetricSnapshot < ActiveRecord::Base
  belongs_to :project
  belongs_to :metric
  
  def as_json(options={})
    result = super()
    result[:is_stale] = stale?
    result[:metric_name] = metric.name
    result
  end

  def stale?
    datetime < Time.now - 3.day &&  updated_at < Time.now - 1.day
  end
    
  def self.update_timestamps(snapshots)
    snapshots.each do |snapshot|
      unless snapshot.nil?
        snapshot.updated_at = Time.now
        snapshot.save
      end
    end
  end

  def self.stale?(snapshots)
    is_stale = false
    snapshots.each do |s|
      if ( s.nil? || s.stale? ) #TODO double check the logic here
        is_stale = true
        break
      end
    end
    is_stale
  end


end

