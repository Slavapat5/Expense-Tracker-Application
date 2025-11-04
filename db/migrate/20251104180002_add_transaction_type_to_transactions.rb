class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :transaction_type, null: false, default: 0
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.date :occurred_on, null: false

      t.timestamps
    end
  end
end
