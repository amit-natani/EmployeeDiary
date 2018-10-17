class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :values, type: Array
end
