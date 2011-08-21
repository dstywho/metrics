class CreateFormulaReportDefinitions < ActiveRecord::Migration
  def self.up
    create_table :evaluations do |t|
      t.integer :formula_id
      t.integer :grade_scale_id
      t.integer :report_definition_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_report_definitionss
  end
end
