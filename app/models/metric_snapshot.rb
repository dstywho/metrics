class MetricSnapshot < ActiveRecord::Base
  belongs_to :project
  belongs_to :metric
  
  def stale?
    datetime < Time.now - 3.day &&  updated_at < Time.now - 1.day
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

