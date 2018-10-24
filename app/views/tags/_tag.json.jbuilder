json.extract! tag, :name, :values, :created_at, :updated_at
json.set! :id, tag.id.to_s
json.url tag_url(tag, format: :json)
