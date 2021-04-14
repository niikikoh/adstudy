json.extract! profile, :id, :name, :bio, :avatar, :user_id, :article_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
