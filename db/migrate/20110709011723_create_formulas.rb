class CreateFormulas < ActiveRecord::Migration
  def self.up
    create_table :formulas do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :formulas
  end
end
