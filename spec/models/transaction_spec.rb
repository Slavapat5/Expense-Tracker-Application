require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before do
    @user = User.create!(email: "test@example.com", password: "password")
    @category = Category.create!(name: "Food", user: @user)
  end

  it "is valid with valid attributes" do
    transaction = Transaction.new(
      user: @user,
      category: @category,
      amount: 20.5,
      occurred_on: Date.today
    )
    expect(transaction).to be_valid
  end

  it "is invalid without an amount" do
    transaction = Transaction.new(user: @user, category: @category, amount: nil)
    expect(transaction).to_not be_valid
  end

  it "is invalid without a category" do
    transaction = Transaction.new(user: @user, category: nil, amount: 10)
    expect(transaction).to_not be_valid
  end
end
