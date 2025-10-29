json.extract! transaction, :id, :occurred_on, :amount, :note, :category_id, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
