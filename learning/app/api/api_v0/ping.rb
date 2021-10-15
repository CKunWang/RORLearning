module ApiV0
  class Ping < Grape::API
    desc 'Ping pong'
    get "/ping" do
      authenticate!
      authenticate_admin!

      "pong"
    end
  end
end
