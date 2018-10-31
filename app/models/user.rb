class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :middle_name, type: String
  field :ref_id, type: Integer
  field :is_active, type: Boolean, default: true

  has_many :entries

  def name
    if middle_name.present?
      first_name + " " + middle_name + " " + last_name
    else
      first_name + " " + last_name
    end
  end
end
