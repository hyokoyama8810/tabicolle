class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :general_memo
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :courses, [:user_id, :created_at]
  end
end
