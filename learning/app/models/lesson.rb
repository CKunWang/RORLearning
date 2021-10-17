class Lesson < ApplicationRecord

  has_many :user_purchase_lessons
  has_many :devise_users, :through => :user_purchase_lessons

  validates_presence_of :subject, :currency, :price, :lesson_type, :url, :description, :expired_days
end
