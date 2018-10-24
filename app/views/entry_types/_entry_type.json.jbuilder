json.extract! entry_type, :name, :versions, :active_version, :created_at, :updated_at
json.set! :id, entry_type.id.to_s
json.url entry_type_url(entry_type, format: :json)
