class AddUserToCategories < ActiveRecord::Migration[7.0]
  def change
    # Step 1: Add the column allowing nulls first
    add_reference :categories, :user, foreign_key: true, null: true
  end
end
