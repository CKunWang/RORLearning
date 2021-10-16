class Lesson < ApplicationRecord
  belongs_to :devise_user, optional: true

  validates_presence_of :subject, :currency, :price, :lesson_type, :is_available, :url, :description, :expired_days
end
