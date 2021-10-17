class CreateUserPurchaseLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :user_purchase_lessons do |t|
      t.integer :devise_user_id
      t.integer :lesson_id
      t.string :currency
      t.integer :price
      t.datetime :expired_time

      t.timestamps
    end
  end
end
