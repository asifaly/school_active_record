class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :student, index: true, foreign_key: true
      t.integer :english
      t.integer :hindi
      t.integer :mathematics
      t.integer :science
      t.integer :social

      t.timestamps null: false
    end
  end
end
