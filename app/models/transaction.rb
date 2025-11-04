class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  enum transaction_type: { expense: 0, income: 1 }

  validates :amount, presence: true, numericality: true
  validates :occurred_on, presence: true
end
