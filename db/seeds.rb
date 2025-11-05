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
user = User.find_or_create_by!(email: "test@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
end


# Create categories
food = Category.create!(name: "Food", user: user)
salary = Category.create!(name: "Salary", user: user)

# Create transactions
Transaction.create!(
  amount: 50,
  occurred_on: Date.today - 2,
  transaction_type: :expense,
  user: user,
  category: food
)

Transaction.create!(
  amount: 1000,
  occurred_on: Date.today - 1,
  transaction_type: :income,
  user: user,
  category: salary
)
