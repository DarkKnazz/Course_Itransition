json.extract! post, :id, :users_id, :name, :rate, :created_at, :updated_at
json.url post_url(post, format: :json)
