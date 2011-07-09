class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :key
      t.integer :external_id
      t.string :version
      t.date :date
      
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
