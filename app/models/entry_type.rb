class EntryType
  include Mongoid::Document
  include Mongoid::Timestamps

  # store_in collection: "citizens", database: "other", client: "secondary"
  # store_in database: ->{ Thread.current[:database] }

  field :name, type: String
  field :active_version, type: String
  field :create_url, type: String
  field :view_url, type: String
  field :versions, type: Hash
  field :parent_id, type: String
  field :instantiable, type: Boolean

  validates_presence_of :name
end
