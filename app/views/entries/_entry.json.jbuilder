json.extract! entry, :description, :tagged_users, :cost_head, :approval_desision_by, :approval_decision_at, :status, :needs_approval, :shared_with, :version, :sharing_level, :created_at, :updated_at
json.set! :id, entry.id.to_s
json.owner_user do
  json.partial! "users/user", user: entry.owner
end
json.entry_type do
  json.partial! "entry_types/entry_type", entry_type: EntryType.find(entry.entry_type_id)
end
json.content do
  entry.content.each do |key, value|
    if value.is_a?(Hash)
      json.set! key, value['display_name']
    else
      json.set! key, value
    end
  end
end
json.url entry_url(entry, format: :json)
