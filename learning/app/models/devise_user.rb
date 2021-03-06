class DeviseUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :api_access_tokens

  has_many :user_purchase_lessons
  has_many :lessons, :through => :user_purchase_lessons

  def isAdmin?
    self.role == "admin"
  end
end
