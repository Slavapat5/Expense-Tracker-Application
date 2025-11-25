require "rails_helper"

RSpec.describe "Transactions", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password123") }

  # Log the user in via Devise (same trick we used before)
  before do
    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password123"
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
            occurred_on: Date.today,
            amount: 20,
            note: "Test",
            category_id: category.id
          }
        }
      }.to change(Transaction, :count).by(1)

      expect(response).to redirect_to(Transaction.last)
    end
  end

  describe "PATCH /update" do
    it "updates an existing transaction" do
      category = Category.create!(name: "Bills", user: user)
      tx = Transaction.create!(
        occurred_on: Date.today,
        amount: 50,
        note: "Old note",
        category: category,
        user: user
      )

      patch transaction_path(tx), params: {
        transaction: {
          note: "Updated note"
        }
      }

      expect(response).to redirect_to(transaction_path(tx))
      expect(tx.reload.note).to eq("Updated note")
    end
  end

  describe "DELETE /destroy" do
    it "deletes a transaction" do
      category = Category.create!(name: "Fun", user: user)
      tx = Transaction.create!(
        occurred_on: Date.today,
        amount: 10,
        note: "Cinema",
        category: category,
        user: user
      )

      expect {
        delete transaction_path(tx)
      }.to change(Transaction, :count).by(-1)

      expect(response).to redirect_to(transactions_path)
    end
  end
end
