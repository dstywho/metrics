class CreateMetrics < ActiveRecord::Migration
  def self.up
    create_table :metrics do |t|
      t.string :name
      t.string :description
      t.string :source
      t.integer :direction
      t.boolean :qualitative
      t.string :val_type

      t.timestamps
    end
  end

  def self.down
    drop_table :metrics
  end
end
