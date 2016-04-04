class CreateAbsentees < ActiveRecord::Migration
  def change
    create_table :absentees do |t|
      t.references :student, index: true, foreign_key: true
      t.references :attendance_registry, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
