class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :middle_name, type: String
  field :ref_id, type: Integer
  field :is_active, type: Boolean
end
