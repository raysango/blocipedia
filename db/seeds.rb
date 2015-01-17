require 'faker'
 
#Create Users
5.times do
  user = User.new(
    name:  Faker::Name.name,
    email:  Faker::Internet.email,
    password:  Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users=User.all

# Create Wikis
30.times do
  Wiki.create!(
    user: users.sample,
    title:        Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
    )
end
# Create an admin user
default = User.new(
  name: "Raymond Morcos",
  email: "remongeorge@live.com",
  password: "password",
  role: "standard"
  )
default.skip_confirmation!
default.save!

admin = User.new(
  name: "Admin User",
  email: "admin@example.com",
  password: "password",
  role: "admin"
  )
admin.skip_confirmation!
admin.save!

#Create a premium
premium = User.new(
  name: "Premium User",
  email: "premium@example.com",
  password: "password",
  role: "premium"
  )
premium.skip_confirmation!
premium.save!


 puts "Seed finished"
 puts "#{User.count} users created" 
puts "#{Wiki.count} wikis created"