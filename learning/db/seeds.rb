# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

#User.create(account: "admin", password: "123456", role: "manager")

DeviseUser.create! :email => 'admin@gmail.com', :password => '123456789', :password_confirmation => '123456789', :role=>'admin'
DeviseUser.create! :email => 'user@gmail.com', :password => '123456789', :password_confirmation => '123456789', :role=>'user'
