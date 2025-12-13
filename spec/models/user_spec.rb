# spec/models/user_spec.rb
require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with a valid email and password" do
      user = User.new(email: "user@example.com", password: "password123")
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = User.new(email: nil, password: "password123")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it "is invalid with a duplicate email" do
      User.create!(email: "user@example.com", password: "password123")
      duplicate = User.new(email: "user@example.com", password: "password123")

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:email]).to be_present
    end
  end

  describe "associations" do
    it "has many transactions" do
      association = described_class.reflect_on_association(:transactions)
      expect(association.macro).to eq(:has_many)
    end

    it "has many categories" do
      association = described_class.reflect_on_association(:categories)
      expect(association.macro).to eq(:has_many)
    end
  end
end
