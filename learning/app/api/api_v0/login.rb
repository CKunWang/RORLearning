module ApiV0
  class Login < Grape::API
    desc 'user login'
    post "/login" do

      user = DeviseUser.find_by(email: params[:email])

      raise LoginError if user.blank? || !user.valid_password?(params[:password])

      puts "auth success generate token #{user.id}"

      token = ApiAccessToken.new

      token.user_id = user.id

      utc_now = Time.now.utc

      token.expired_time = utc_now + 1.hours

      token.save

      token.key

    end

  end

end

