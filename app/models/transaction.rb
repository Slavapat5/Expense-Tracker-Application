class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :amount, presence: true, numericality: true
  validates :occurred_on, presence: true
end

