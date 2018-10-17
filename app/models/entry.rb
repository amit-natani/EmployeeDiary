class Entry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author_id, type: Integer
  field :mentioned_user_ids, type: Array
  field :title, type: String
  field :related_to, type: String
  field :entry_type_id, type: String
  field :version, type: String
  field :duration, type: BigDecimal
  field :content, type: Hash
  field :shared_with, type: Hash
  field :needs_approval, type: Boolean
  field :status, type: String
  field :approver_ids, type: Array
  field :approval_decision_at, type: DateTime
  field :approval_desision_by, type: Integer

  validates_presence_of :needs_approval, :status, :version, :entry_type_id, :author_id

  validate :validate_entry_contents

  def validate_entry_contents
    if(entry_type_id.present?)
      @entry_type = EntryType.find(entry_type_id)
      if !content.present?
        if @entry_type && @entry_type.versions.present?
          @active_version = @entry_type.versions[@entry_type.active_version]
          @active_version['attributes'].each do |attribute|
            if attribute['required'] == true
              errors.add(attribute['attribute_name'], "can't be blank")
            end
          end
        end
      else
        @active_version = @entry_type.versions[@entry_type.active_version]
        merge_json do |d, v|
          if (d['required'] == 'true' || d['required'] == true) && !v.present?
            errors.add(d['attribute_name'], "can't be blank")
          end
        end
      end
      !errors.present?
    end
  end

  def merge_json
    if block_given? && @active_version.present?
      @active_version['attributes'].each do |attribute|
        yield attribute, content[attribute['attribute_name']]
      end
    end
  end

  def set_default_params
    entry_type = EntryType.find(entry_type_id)
    self.version = entry_type.active_version
    self.needs_approval = false
    self.status = "not_required"
    self.author_id = User.last._id
  end
end
