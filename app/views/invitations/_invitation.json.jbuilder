json.extract! invitation, :id, :role, :status, :dig_id, :sender_id, :recipient_id, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
