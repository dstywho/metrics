class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.references :report_definition
      t.references :formula
      t.references :grading_scale
      t.references :grade
      t.float      :decimal

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
