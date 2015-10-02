# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



99.times do |n|
  login2 = Faker::Name.first_name
  password = "password"
  User.create!(login:  login2,
               password:              password,
               password_confirmation: password,
               avatar: File.open(File.join(Rails.root, 'db', 'fixtures',
'dflt_avatar.png')))
end