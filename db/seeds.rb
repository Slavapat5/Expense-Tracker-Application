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

# --- Users ---
users = [
  { email: "test1@example.com", password: "password", password_confirmation: "password" },
  { email: "test2@example.com", password: "password", password_confirmation: "password" }
]

users.each do |u|
  User.find_or_create_by!(email: u[:email]) do |user|
    user.password = u[:password]
    user.password_confirmation = u[:password_confirmation]
  end
end

puts "Users created!"

# --- Categories ---
categories = ["Food", "Transport", "Entertainment", "Salary", "Other"]

categories.each do |cat|
  Category.find_or_create_by!(name: cat)
end

puts "Categories created!"

# --- Transactions (safe check) ---
if Transaction.column_names.include?("transaction_type")
  # Only run if transaction_type column exists
  Transaction.find_or_create_by!(
    user: User.first,
    category: Category.first,
    transaction_type: :income,
    amount: 100.0,
    occurred_on: Date.today
  )
  Transaction.find_or_create_by!(
    user: User.last,
    category: Category.second,
    transaction_type: :expense,
    amount: 50.0,
    occurred_on: Date.today
  )

  puts "Sample transactions created!"
else
  puts "Skipping transactions: transaction_type column not found yet."
end
