json.extract! user, :first_name, :last_name, :is_active, :middle_name, :ref_id, :created_at, :updated_at
json.set! :id, user.id.to_s
json.set! :name, user.name
json.url user_url(user, format: :json)
