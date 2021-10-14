class ApiAccessToken < ApplicationRecord

  belongs_to :devise_user, optional: true

  before_create :generate_keys

  private

  def generate_keys
    begin
      self.key = SecureRandom.urlsafe_base64(30).tr('_-', 'xx')
    end while ApiAccessToken.where(key: key).any?
  end

end
