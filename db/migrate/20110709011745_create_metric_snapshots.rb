class CreateMetricSnapshots < ActiveRecord::Migration
  def self.up
    create_table :metric_snapshots do |t|
      t.integer :metric_id
      t.integer :project_id
      t.decimal :value
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :metric_snapshots
  end
end
