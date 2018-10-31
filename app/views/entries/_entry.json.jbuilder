json.extract! entry, :content, :title, :created_at, :updated_at
json.set! :id, entry.id.to_s
json.owner_user do
  json.partial! "users/user", user: entry.owner
end
json.url entry_url(entry, format: :json)
