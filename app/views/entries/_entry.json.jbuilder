json.extract! entry, :content, :title, :created_at, :updated_at
json.set! :id, entry.id.to_s
json.url entry_url(entry, format: :json)
