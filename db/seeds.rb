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
# db/seeds.rb

# --- Users ---user = User.create!(email: "test@example.com", password: "password")
# Clear existing data in correct order (transactions first to avoid foreign key errors)
# Clear data in the correct order
Transaction.delete_all
Category.delete_all
User.delete_all

puts "Creating test user..."

user = User.create!(
  email: "test@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "Creating categories..."
food = Category.create!(name: "Food", user: user)
rent = Category.create!(name: "Rent", user: user)
fun = Category.create!(name: "Fun", user: user)

puts "Creating transactions..."
Transaction.create!([
  {
    occurred_on: Date.today,
    amount: 20.50,
    note: "Lunch",
    category: food,
    user: user
  },
  {
    occurred_on: Date.today - 1,
    amount: 800,
    note: "Monthly rent",
    category: rent,
    user: user
  },
  {
    occurred_on: Date.today - 2,
    amount: 15.00,
    note: "Cinema",
    category: fun,
    user: user
  }
])

puts "Seeding completed successfully!"

