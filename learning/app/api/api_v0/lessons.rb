module ApiV0
  class Lessons < Grape::API
    before { authenticate! }

    desc "Get all lessons"
    get "/lessons" do
      authenticate_admin!
      lessons = Lesson.all

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

  end
end
