require "rails_helper"

RSpec.describe "User creates a transaction", type: :system do
  it "logs in and creates a transaction via the UI" do
    # 1. Prepare a user
    user = User.create!(
      email: "systemtest@example.com",
      password: "password123"
    )

    # 2. Log in through the Devise login form
    visit new_user_session_path

    fill_in "Email",    with: user.email
    fill_in "Password", with: "password123"
    click_button "Log in"

    # Expects to see something that only appears after login
    expect(page).to have_link("Transactions")

    # 3. Create a category using the UI
    click_link "Categories"
    click_link "New Category"

    fill_in "Name", with: "Food"
    click_button "Create Category"

    expect(page).to have_content("Food")

    # 4. Create a transaction using the UI
    click_link "Transactions"

    # Use the navbar “New Transaction” link to avoid ambiguity
    within("nav.navbar") do
      click_link "New Transaction"
    end

    # Fill in the transaction form using field IDs
    fill_in "transaction_occurred_on", with: Date.today.to_s   # "YYYY-MM-DD"
    fill_in "transaction_amount",      with: "25.50"
    fill_in "transaction_note",        with: "System spec lunch"

    # Category select
    select "Food", from: "transaction_category_id"

    click_button "Create Transaction"

    # 5. Confirm it worked
    expect(page).to have_content("Transaction was successfully created")
    expect(page).to have_content("System spec lunch")
    expect(page).to have_content("Food")
    expect(page).to have_content("25.50")
  end
end

