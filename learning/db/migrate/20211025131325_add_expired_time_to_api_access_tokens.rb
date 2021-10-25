class AddExpiredTimeToApiAccessTokens < ActiveRecord::Migration[5.0]
  def change
    add_column :api_access_tokens, :expired_time, :datetime 
  end
end
