module ApiV0
  class Lessons < Grape::API
    before { authenticate! }

    desc "Get all lessons"
    get "/lessons" do
      authenticate_admin!
      lessons = Lesson.all

      present lessons, with: ApiV0::Entities::Lesson
    end

    desc "Get available lessons"
    get "/lessons/available" do

      lessons = Lesson.where(:is_available == true)

      present lessons, with: ApiV0::Entities::Lesson
    end


    desc "Create new lesson"
    params do
      requires :subject, type: String
      requires :currency, type: String
      requires :price, type: Integer
      requires :lesson_type, type: String
      requires :is_available, type: Boolean
      requires :url, type: String
      requires :description, type: String
      requires :expired_days, type: Integer
    end
    post "/lessons" do

      authenticate_admin!
      lesson = Lesson.new(declared(params, include_missing: false).except(:access_key))

      if lesson.save
        present lesson, with: ApiV0::Entities::Lesson
      else
        raise StandardError, $!
      end
    end


    desc "Update a lesson"
    params do
      requires :id, type: Integer
      requires :subject, type: String
      requires :currency, type: String
      requires :price, type: Integer
      requires :lesson_type, type: String
      requires :is_available, type: Boolean
      requires :url, type: String
      requires :description, type: String
      requires :expired_days, type: Integer
    end
    patch "/lessons/:id" do

      authenticate_admin!
      lesson = Lesson.find_by(id: params[:id])

      if lesson.update(declared(params, include_missing: false).except(:access_key))
        present lesson, with: ApiV0::Entities::Lesson
      else
        raise StandardError, $!
      end

    end


    desc "Delete a lesson."
    params do
      requires :id, type: Integer, desc: 'Lesson ID.'
    end
    delete "/lessons/:id" do

      authenticate_admin!
      lesson = Lesson.find_by(id: params[:id])

      if lesson.destroy
        present lesson, with: ApiV0::Entities::Lesson
      else
        raise StandardError, $!
      end
    end

    desc "Purchase a lesson."
    params do
      requires :id, type: Integer, desc: 'Lesson ID.'
    end
    post "/lessons/:id/purchase" do

      user = current_user
      lesson = Lesson.find_by(id: params[:id], is_available: true)

      raise LessonNotFoundError if lesson.blank?

      # check if user had bought same lesson
      utc_now = Time.now.utc
      duplicate_lesson = UserPurchaseLesson.where(:devise_user_id => user.id, :lesson_id => lesson.id).where("expired_time > ?", utc_now)
      raise DuplicatePurchaseError if not duplicate_lesson.blank?

      #utc_expired_time = Time.now.utc + lesson.expired_days.minutes
      utc_expired_time = utc_now + lesson.expired_days.days

      purchase_map = UserPurchaseLesson.create(:devise_user => user, :lesson => lesson, :currency => lesson.currency, :price => lesson.price, :expired_time => utc_expired_time)



      if purchase_map
        present purchase_map, with: ApiV0::Entities::PurchaseRecord
      else
        raise StandardError, $!
      end
    end



    desc "get purchased lesson"
    get "/lessons/purchased" do

      purchase_map = UserPurchaseLesson.where(:devise_user_id => current_user.id)

      lesson_ids = []

      purchase_map.each { |map| lesson_ids.push(map.lesson_id) }

      lesson_ids = lesson_ids.uniq

      puts lesson_ids.inspect

      purchased_lesson = Lesson.where(id: lesson_ids)

      puts purchased_lesson.inspect

      data = { :purchased_maps => purchase_map, :lessons => purchased_lesson }

      present data, with: ApiV0::Entities::PurchasedLesson

      
    end


  end
end
