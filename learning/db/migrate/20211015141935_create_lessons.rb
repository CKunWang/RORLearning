class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :subject
      t.string :currency
      t.integer :price
      t.string :lesson_type
      t.boolean :is_available
      t.string :url
      t.text :description
      t.integer :expired_days

      t.timestamps
    end
  end
end
