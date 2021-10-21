class ApiRoot < Grape::API
  PREFIX = '/api'.freeze

  puts "api root"

  format :json

  mount ApiV0::Base
end
