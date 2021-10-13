class AddRoleToDeviceUser < ActiveRecord::Migration[5.0]
  def change
    add_column :devise_users, :role, :string
  end
end
