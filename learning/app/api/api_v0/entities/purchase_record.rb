module ApiV0
  module Entities
    class PurchaseRecord < Entities::Base
      expose :id
      expose :devise_user_id
      expose :lesson_id
      expose :created_at, format_with: :iso8601
      expose :expired_time, format_with: :iso8601
    end
  end
end
