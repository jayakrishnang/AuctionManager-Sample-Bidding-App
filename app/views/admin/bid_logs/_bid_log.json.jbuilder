json.extract! bid_log, :id, :amount, :user_id, :created_at, :updated_at
json.url bid_log_url(bid_log, format: :json)