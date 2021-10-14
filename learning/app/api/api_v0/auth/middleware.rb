module ApiV0
  module Auth
    class Middleware < Grape::Middleware::Base
      def before
        if auth_provided?
          @env["api_v0.token"] = Authenticator.new(request, params).authenticate!
          
          
          #@env["api_v0.user"] ||= @env["api_v0.token"].try(:devise_user) 

          user = DeviseUser.find(@env["api_v0.token"].user_id) if not @env["api_v0.token"].blank?

          @env["api_v0.user"] ||= user if not user.blank?
        end
      end

      def request
        @request ||= ::Grape::Request.new(env)
      end

      def params
        @params ||= request.params
      end

      def auth_provided?
        params[:access_key].present?
      end
    end
  end
end
