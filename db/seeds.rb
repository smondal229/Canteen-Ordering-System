# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create(
  email: "email@abc.com",
  password: "1234",
  password_confirmation: "1234",
)

for i in 1..5 do
  Company.create(name: "company#{i}")
  Employee.create(email: "emp#{i}@abc.com", password: "1234", password_confirmation: "1234")
  Chef.create(email: "chef#{i}@abc.com", password: "1234", password_confirmation: "1234")
end

Company.create(name: "Others")

Employee.create(email: "smondal229@gmail.com", password: "1234", password_confirmation: "1234")


categories = ["Chinese", "North Indian", "South Indian", "Italian", "Continental", "Beverages", "Snacks", "Main Course"]

categories.each do |cat|
  Category.create(name: cat)
end

FoodStore.create(name: "Mainland China")
FoodStore.create(name: "KFC")
FoodStore.create(name: "StarBucks India")
FoodStore.create(name: "Madras Cafe")
FoodStore.create(name: "China Bytes")
FoodStore.create(name: "French Cafe")
FoodStore.create(name: "Pizza Hut")
FoodStore.create(name: "Domino's Pizza")
FoodStore.create(name: "Food Plaza")

FoodStore.find_each do |store|
  for i in 1..10 do
    f = store.foods.new(name: "Food#{i}", price: 10*rand(4..60))
    f.category = Category.find(rand(1..8))
    f.save
  end
end

Statuses = [ "Recieved", "Cooking", "Prepared", "Delivered" ]

Statuses.each do |status|
  Status.create(name: status)
end