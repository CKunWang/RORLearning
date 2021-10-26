require 'rails_helper'

describe "get all questions route", :type => :request do

  before(:all) do
    @user = DeviseUser.create! :email => 'spec_admin@gmail.com', :password => '123456789', :password_confirmation => '123456789', :role=>'admin'
    @token = ApiAccessToken.create! :user_id => @user.id, :expired_time => Time.now.utc + 1.hours
    Lesson.create! :subject => "test", :currency => "TWD", :price => 90, :lesson_type => "program", :is_available => true, :url => "http://localhost:3000/api/v0/lesson", :description => "test spec", :expired_days => 20

    Lesson.create! :subject => "test2", :currency => "TWD", :price => 90, :lesson_type => "program", :is_available => true, :url => "http://localhost:3000/api/v0/lesson", :description => "test spec", :expired_days => 20
  end

  before do 
    get '/api/v0/lessons', nil, {'token' => @token.key }
  end

  it 'returns all lessons' do
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
