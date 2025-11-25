require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password") }

  before do
    # Log in using Devise sign-in route
    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }
  end

  describe "GET /index" do
    it "returns a successful response" do
      get transactions_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new transaction" do
      category = Category.create!(name: "Food", user: user)

      expect {
        post transactions_path, params: {
          transaction: {
            amount: 20,
            occurred_on: Date.today,  # ← REQUIRED FIELD
            category_id: category.id
          }
        }
      }.to change(Transaction, :count).by(1)
    end
  end
end
