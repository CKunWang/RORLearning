FactoryBot.define do

  currency_array = ["TWD", "USD","HKD"]
  lesson_type_array = ["education", "programming", "life style", "travel"]

  factory :admin, class: DeviseUser do
    email { "admin1@mail.com" }
    password { "123456789" }
    password_confirmation { "123456789" }
    role { "admin" }
  end

  factory :token_one_hour, class: DeviseUser do
    key { "spec" }
    expired_time { Time.now.utc + 1.hours }
  end
end
