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
  field :instantiable, type: Boolean, default: false
  field :cost_head, type: String
  field :cost_head_id, type: String

  # Associations
  has_many :entries, dependent: :nullify

  # validataions
  validates_presence_of :name

  scope :non_instantiable, -> { where(instantiable: false) }

  scope :sub_entry_types, -> (parent_id) do
     where(parent_id: parent_id.to_s) 
  end

  scope :all_sub_entry_types, -> do
    where(instantiable: true) 
 end
end
