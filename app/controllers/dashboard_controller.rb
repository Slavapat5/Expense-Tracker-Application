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

    # Spending last month
    last_month_range = (Date.current.last_month.beginning_of_month..Date.current.last_month.end_of_month)
    @last_month_spent = @transactions
      .where(occurred_on: last_month_range)
      .sum(:amount)

    # Spending by category (for pie chart)
    @spending_by_category = @transactions
      .joins(:category)
      .group("categories.name")
      .sum(:amount)

    # Recent transactions
    @recent_transactions = @transactions.order(occurred_on: :desc).limit(5)

    # Monthly spending (for line chart)
    monthly_data = @transactions.group_by { |t| t.occurred_on.beginning_of_month }
    @months = monthly_data.keys.sort.map { |date| date.strftime("%b %Y") }
    @monthly_totals = monthly_data.keys.sort.map { |date| monthly_data[date].sum(&:amount) }

    # Spending insights
    if @last_month_spent > 0
      change = ((@month_spent - @last_month_spent) / @last_month_spent.to_f * 100).round(1)
      if change > 0
        @insight_message = "You spent #{change}% more this month than last month."
      elsif change < 0
        @insight_message = "You spent #{change.abs}% less this month than last month."
      else
        @insight_message = "Your spending is the same as last month."
      end
    else
      @insight_message = "No spending data for last month to compare."
    end
  end
end
