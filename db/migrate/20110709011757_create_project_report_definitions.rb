class CreateProjectReportDefinitions < ActiveRecord::Migration
  def self.up
    create_table :project_report_definitions do |t|
      t.integer :project_id
      t.integer :report_definition_id

      t.timestamps
    end
  end

  def self.down
    drop_table :project_report_definitions
  end
end
