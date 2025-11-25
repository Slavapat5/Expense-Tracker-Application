require "rails_helper"

RSpec.describe Transaction, type: :model do
  let(:user)     { User.create!(email: "test@example.com", password: "password123") }
  let(:category) { Category.create!(name: "Food", user: user) }

  it "is valid with amount, occurred_on, category and user" do
    tx = Transaction.new(
      occurred_on: Date.today,
      amount: 12.34,
      note: "Lunch",
      category: category,
      user: user
    )
    expect(tx).to be_valid
  end

  it "is invalid without amount" do
    tx = Transaction.new(
      occurred_on: Date.today,
      amount: nil,
      category: category,
      user: user
    )
    expect(tx).not_to be_valid
    expect(tx.errors[:amount]).to be_present
  end

  it "is invalid with non-numeric amount" do
    tx = Transaction.new(
      occurred_on: Date.today,
      amount: "abc",
      category: category,
      user: user
    )
    expect(tx).not_to be_valid
    expect(tx.errors[:amount]).to be_present
  end

  it "is invalid without occurred_on" do
    tx = Transaction.new(
      occurred_on: nil,
      amount: 10,
      category: category,
      user: user
    )
    expect(tx).not_to be_valid
    expect(tx.errors[:occurred_on]).to be_present
  end

  it "is invalid without category" do
    tx = Transaction.new(
      occurred_on: Date.today,
      amount: 10,
      category: nil,
      user: user
    )
    expect(tx).not_to be_valid
    expect(tx.errors[:category]).to be_present
  end

  it "is invalid without user" do
    tx = Transaction.new(
      occurred_on: Date.today,
      amount: 10,
      category: category,
      user: nil
    )
    expect(tx).not_to be_valid
    expect(tx.errors[:user]).to be_present
  end

  it "belongs to user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it "belongs to category" do
    association = described_class.reflect_on_association(:category)
    expect(association.macro).to eq(:belongs_to)
  end
end
