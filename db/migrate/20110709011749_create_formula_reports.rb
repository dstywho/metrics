class CreateFormulaReports < ActiveRecord::Migration
  def self.up
    create_table :formula_reports do |t|
      t.integer :formula_id
      t.integer :report_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_reports
  end
end
