class UserPurchaseLesson < ApplicationRecord
  belongs_to :devise_user
  belongs_to :lesson
end
