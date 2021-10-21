module ApiV0
  class Signup < Grape::API

    desc 'user signup'
    params do
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post "/signup/user" do

      raise DuplicateEmailError if not DeviseUser.where(:email => params[:email]).blank?

      user = DeviseUser.create!( :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation], :role=>'user')

    rescue ActiveRecord::RecordInvalid => e
      puts e.inspect
      p e.message
      raise InvaildSignupError      

    end

  end

end
