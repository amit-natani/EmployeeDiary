class Article
  include Mongoid::Document
  field :name, type: String
  field :content, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime
end
