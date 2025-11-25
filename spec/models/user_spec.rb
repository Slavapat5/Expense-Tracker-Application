require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid with email and password" do
    user = User.new(email: "user@example.com", password: "password123")
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = User.new(email: nil, password: "password123")
    expect(user).not_to be_valid
    expect(user.errors[:email]).to be_present
  end

  it "enforces unique email" do
    User.create!(email: "dup@example.com", password: "password123")
    user2 = User.new(email: "dup@example.com", password: "password123")

    expect(user2).not_to be_valid
    expect(user2.errors[:email]).to be_present
  end

  it "has many transactions" do
    association = described_class.reflect_on_association(:transactions)
    expect(association.macro).to eq(:has_many)
  end

  it "has many categories" do
    association = described_class.reflect_on_association(:categories)
    expect(association.macro).to eq(:has_many)
  end
end
