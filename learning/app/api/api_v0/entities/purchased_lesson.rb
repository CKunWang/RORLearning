module ApiV0
  module Entities
    class PurchasedLesson < Entities::Base

      expose :purchased_maps, using: ApiV0::Entities::PurchaseRecord
      expose :lessons, using: ApiV0::Entities::Lesson
    end
  end
end
