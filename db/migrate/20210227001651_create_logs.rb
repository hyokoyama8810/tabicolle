class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :spot
      t.time :time
      t.string :detailed_memo
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
