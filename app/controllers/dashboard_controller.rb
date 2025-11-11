class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.includes(:category)

    # Total spending (all time)
    @total_spent = @transactions.sum(:amount)

    # Spending this month
    @month_spent = @transactions
      .where(occurred_on: Date.current.beginning_of_month..Date.current.end_of_month)
      .sum(:amount)

    # Spending by category
    @spending_by_category = @transactions
      .joins(:category)
      .group("categories.name")
      .sum(:amount)

    # Recent transactions
    @recent_transactions = @transactions.order(occurred_on: :desc).limit(5)
  end
end
