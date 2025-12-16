# Expense Tracker

A simple Rails + PostgreSQL web app that lets users track their expenses in categories, see summaries, and view charts on a dashboard.

---

## 1. What the app does

Logged-in users can:

- Sign up / log in / log out (Devise).
- Create, edit, and delete **categories** (e.g. Food, Rent).
- Create, edit, and delete **transactions**:
  - Date (`occurred_on`)
  - Amount
  - Optional note
  - Category
- Filter and sort their own transactions.
- See a **dashboard** with:
  - Total spending
  - This month’s spending
  - Simple spending insight text
  - Pie chart: spending by category
  - Line chart: monthly spending

All data is scoped to the current user (`current_user`) so users only see their own categories and transactions.

---

## 2. Tech stack

- **Backend**: Ruby on Rails 8.0.4
- **Language**: Ruby 3.4.6
- **Database**: PostgreSQL
- **Auth**: Devise
- **UI**: Bootstrap 5 (with CDN)
- **Charts (library)**: Chart.js (with CDN)
- **Tests**: RSpec + Capybara
- **CI**: GitHub Actions (runs RSpec on push / PR)
- **Deployment**: Heroku (`nameless-ravine-67561`)

---

## 3. Setup (local)

### 3.1 Prerequisites

- Ruby 3.4.6
- PostgreSQL running locally
- Bundler
- Git

### 3.2 Clone and install

    git clone https://github.com/Slavapat5/Expense-Tracker-Application expense_tracker
    cd expense_tracker

    bundle install

### 3.3 Configure database

Check `config/database.yml` has something like:

    development:
      adapter: postgresql
      encoding: unicode
      database: expense_tracker_development
      pool: 5

    test:
      adapter: postgresql
      encoding: unicode
      database: expense_tracker_test
      pool: 5

Then run:

    bin/rails db:create
    bin/rails db:migrate
    bin/rails db:seed

The seed creates a sample user:

- Email: `test@example.com`
- Password: `password123`

### 3.4 Run the server

    bin/rails server
    # or: rails server

Open:

- http://localhost:3000

Log in with the seeded user or sign up for a new account.

---

## 4. Main screens

### 4.1 Navbar

- Shows when user is logged in.
- Links:
  - Dashboard
  - Transactions
  - New Transaction
  - My Categories
  - Login / Sign Up / Logout
- “Quick Add” dropdown lets you start a new transaction for a chosen category.

### 4.2 Transactions

- List of your transactions.
- Filters:
  - By category
  - By date range
- Sorting:
  - Newest / oldest
  - Amount low → high / high → low
- Pagination at the bottom using Kaminari.
- Links to edit or delete each transaction.

### 4.3 Categories

- List of your categories.
- Create, edit, delete categories.
- Category names must be unique per user.
- If a category has related transactions, the app prevents deletion and shows a friendly message.

### 4.4 Dashboard

- Cards for:
  - Total spending (all time)
  - This month’s spending
  - Short insight message (e.g. more or less spending than last month)
- Charts using Chart.js:
  - Pie chart: spending by category
  - Line chart: monthly spending
- “Refresh charts” button in case the browser does not fully reload the page.

---

## 5. Testing

To run tests locally:

    bin/rails db:test:prepare
    bundle exec rspec

What is covered:

- **Model tests** (`spec/models`):
  - `Category` validations and `belongs_to :user`.
  - `Transaction` validations and `belongs_to :user` / `belongs_to :category`.

- **Request tests** (`spec/requests`):
  - Categories:
    - GET index
    - POST create
    - PATCH update
    - DELETE destroy
  - Transactions:
    - GET index
    - POST create
    - PATCH update
    - DELETE destroy

- **System test** (`spec/system`):
  - Logs in through the Devise login form.
  - Creates a category via the UI.
  - Creates a transaction via the UI and checks it appears on the page.

---

## 6. CI and deployment

### 6.1 GitHub Actions (CI)

Workflow file: `.github/workflows/ci.yml`

On each push / pull request:

- Checks out the code.
- Sets up Ruby.
- Starts PostgreSQL 16 service.
- Sets `RAILS_ENV=test`.
- Runs:

    bin/rails db:create
    bin/rails db:schema:load
    bundle exec rspec

This keeps tests running automatically on GitHub.

### 6.2 Heroku deployment

The app is deployed to Heroku:

- App name: `nameless-ravine-67561`

Typical steps:

1. Push to GitHub so CI runs:

       git push origin main

2. Deploy to Heroku from GitHub (through the Heroku dashboard or pipeline).

3. Run migrations (and optional seeds) on Heroku:

       heroku run rails db:migrate -a nameless-ravine-67561
       heroku run rails db:seed   -a nameless-ravine-67561   # optional

The live URL and video link are included in the project report.
