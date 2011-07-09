class CreateFormulaItems < ActiveRecord::Migration
  def self.up
    create_table :formula_items do |t|
      t.integer :item_id
      t.string :item_type
      t.integer :formula_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_items
  end
end
