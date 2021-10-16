module ApiV0
  module Entities
    class Lesson < Entities::Base
      expose :id
      expose :subject
      expose :currency
      expose :price
      expose :lesson_type
      expose :is_available
      expose :url
      expose :description
      expose :expired_days
      expose :created_at, format_with: :iso8601
      expose :updated_at, format_with: :iso8601
    end
  end
end
