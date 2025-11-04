class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  # Enum for transaction type (mapped to integer column)
  enum transaction_type: { expense: 0, income: 1 }

  # Validations
  validates :amount, presence: true, numericality: true
  validates :occurred_on, presence: true
  validates :transaction_type, presence: true
end
