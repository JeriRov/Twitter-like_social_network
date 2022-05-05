# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: "abc@gmail.com", password: "password", password_confirmation: "password", username: 'Saske_Uchiha',first_name: "Sasuke", last_name: "Uchiha" )
User.create(email: "abcd@gmail.com", password: "password", password_confirmation: "password", username: 'Madara_Uchiha', first_name: "Madara", last_name: "Uchiha")

5.times do |x|
  Post.create(body: "Body #{x} Some words for test case for db", user_id: User.first.id)
end
3.times do |x|
  Post.create(body: "Body #{x}  Test case for ass", user_id: User.last.id)
end