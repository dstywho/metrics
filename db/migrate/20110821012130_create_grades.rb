class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.string :name
      t.float :value
      t.references :grading_scale

      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
