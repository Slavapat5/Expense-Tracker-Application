# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create sample users
# db/seeds.rb

# First, clear existing data (optional, useful for development)
Transaction.destroy_all
Category.destroy_all
User.destroy_all

puts "Creating users..."
user1 = User.create!(email: "alice@example.com", password: "password123")
user2 = User.create!(email: "bob@example.com", password: "password123")

puts "Creating categories..."
food = Category.create!(name: "Food", user: user1)
salary = Category.create!(name: "Salary", user: user1)
entertainment = Category.create!(name: "Entertainment", user: user2)

puts "Creating transactions..."
Transaction.create!(
  amount: 25.50,
  transaction_type: "expense",
  occurred_on: Date.today - 3,
  category: food,
  user: user1
)

Transaction.create!(
  amount: 1500.00,
  transaction_type: "income",
  occurred_on: Date.today - 10,
  category: salary,
  user: user1
)

Transaction.create!(
  amount: 40.00,
  transaction_type: "expense",
  occurred_on: Date.today - 1,
  category: entertainment,
  user: user2
)

puts "Seeding done!"
