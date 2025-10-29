class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user
  # this is a test change
end
