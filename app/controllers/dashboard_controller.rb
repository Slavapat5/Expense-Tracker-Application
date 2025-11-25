class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions.includes(:category)

    #  Total spending (all time)
    @total_spent = @transactions.sum(:amount)

    #  Spending this month
    @month_spent = @transactions
      .where(
        occurred_on: Date.current.beginning_of_month..Date.current.end_of_month
      )
      .sum(:amount)

    #  Spending by category (for pie chart)
    @spending_by_category = @transactions
      .joins(:category)
      .group("categories.name")
      .sum(:amount)

    #  Monthly spending for line chart
    monthly_data = @transactions
      .group("DATE_TRUNC('month', occurred_on)")
      .sum(:amount)

    # Sort by month and build aligned labels + values arrays
    sorted_months = monthly_data.sort_by { |month, _| month }

    @monthly_labels = sorted_months.map { |month, _| month.strftime("%b %Y") }
    @monthly_values = sorted_months.map { |_, amount| amount.to_f }

    # (Optional) recent transactions if you still use them
    @recent_transactions = @transactions.order(occurred_on: :desc).limit(5)

    # Simple insight: compare this month vs last month
    last_month_range = (Date.current.last_month.beginning_of_month..Date.current.last_month.end_of_month)
    last_month_spent = @transactions.where(occurred_on: last_month_range).sum(:amount)

    if last_month_spent.zero? && @month_spent.zero?
      @insight_message = "No spending recorded in the last two months."
    elsif last_month_spent.zero?
      @insight_message = "You started tracking spending this month."
    else
      change = ((@month_spent - last_month_spent) / last_month_spent * 100.0).round
      if change > 0
        @insight_message = "You spent #{change}% more this month than last month."
      elsif change < 0
        @insight_message = "You spent #{change.abs}% less this month than last month."
      else
        @insight_message = "Your spending is the same as last month."
      end
    end
  end
end
