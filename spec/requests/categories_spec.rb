require "rails_helper"

RSpec.describe "Categories", type: :request do
  let(:user) { User.create!(email: "test@example.com", password: "password123") }

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
      get categories_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new category for the current user" do
      expect {
        post categories_path, params: {
          category: {
            name: "Groceries"
          }
        }
      }.to change(Category, :count).by(1)

      category = Category.last
      expect(category.user).to eq(user)
      expect(response).to redirect_to(categories_path)
    end
  end

  describe "PATCH /update" do
    it "updates an existing category" do
      category = Category.create!(name: "Old Name", user: user)

      patch category_path(category), params: {
        category: { name: "New Name" }
      }

      expect(response).to redirect_to(categories_path)
      expect(category.reload.name).to eq("New Name")
    end
  end

  describe "DELETE /destroy" do
    it "deletes a category" do
      category = Category.create!(name: "To delete", user: user)

      expect {
        delete category_path(category)
      }.to change(Category, :count).by(-1)

      expect(response).to redirect_to(categories_path)
    end
  end
end
