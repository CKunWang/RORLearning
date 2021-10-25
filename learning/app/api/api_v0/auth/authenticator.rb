module ApiV0
  module Auth
    class Authenticator
      def initialize(request, params)
        @request = request
        @params  = params
      end

      def authenticate!
        check_token!
        token
      end

      def token
        #@token = ApiAccessToken.joins("INNER JOIN devise_users ON devise_users.id = api_access_tokens.user_id").where(key: @params[:access_key]).first
        @token = ApiAccessToken.joins("INNER JOIN devise_users ON devise_users.id = api_access_tokens.user_id").where(key: @request.headers["Token"]).where("expired_time > ?", Time.now.utc).first

        #puts "join token #{@token.inspect}"
      end

      def check_token!
        return @request.headers["Token"] unless token
        #return @params[:access_key] unless token
      end
    end
  end
end
