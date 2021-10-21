module ApiV0
  class Base < Grape::API
    version 'v0', using: :path

    puts "api base"

    use ApiV0::Auth::Middleware

    include ApiV0::ExceptionHandlers

    helpers ::ApiV0::Helpers

    mount Ping
    mount Login
    mount Signup
    mount Lessons
  end
end
