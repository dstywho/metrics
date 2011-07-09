class CreateProjectReports < ActiveRecord::Migration
  def self.up
    create_table :project_reports do |t|
      t.integer :project_id
      t.integer :report_id

      t.timestamps
    end
  end

  def self.down
    drop_table :project_reports
  end
end
