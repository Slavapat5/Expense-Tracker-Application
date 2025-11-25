require "rails_helper"

RSpec.describe Category, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password123") }

  it "is valid with a name and user" do
    category = Category.new(name: "Food", user: user)
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category = Category.new(name: nil, user: user)
    expect(category).not_to be_valid
    expect(category.errors[:name]).to be_present
  end

  it "is invalid without a user" do
    category = Category.new(name: "Food", user: nil)
    expect(category).not_to be_valid
    expect(category.errors[:user]).to be_present
  end

  it "belongs to user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
end
