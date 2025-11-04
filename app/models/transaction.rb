class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :amount, presence: true, numericality: true
  validates :occurred_on, presence: true

  # Only define enum if the column exists
  if column_names.include?("transaction_type")
    enum transaction_type: { expense: 0, income: 1 }
  end
end
