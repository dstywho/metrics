class CreateEvaluations < ActiveRecord::Migration
  def self.up
    create_table :evaluations do |t|
      t.references :gradeing_scale
      t.references :formula
      t.references :report_definition

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluations
  end
end
