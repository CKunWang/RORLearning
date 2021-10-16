class AddDeviseUserToLesson < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :devise_user_id, :integer
  end
end
