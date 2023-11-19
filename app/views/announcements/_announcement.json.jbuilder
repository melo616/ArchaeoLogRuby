json.extract! announcement, :id, :title, :body, :poster_id, :dig_id, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
