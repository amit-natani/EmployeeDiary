class Entry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author_id, type: String
  field :owner_id, type: String
  field :tagged_user_ids, type: Array
  field :sharing_level, type: String
  field :title, type: String
  field :description, type: String
  field :entry_type_id, type: String
  field :version, type: String
  field :content, type: Hash
  field :shared_with, type: Hash
  field :needs_approval, type: Boolean
  field :status, type: String
  field :approver_ids, type: Array
  field :approval_decision_at, type: DateTime
  field :approval_desision_by, type: Integer
  field :cost_head, type: String


  # Association
  belongs_to :entry_type, touch: true
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'


  # Validations
  validates_presence_of :needs_approval, :status, :version, :entry_type_id, :author_id, :description, :sharing_level
  validate :validate_entry_contents


  # Callbacks
  # after_create :update_counts

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
    self.author_id = User.last.id
    self.owner = User.last
    self.cost_head = entry_type.cost_head
  end

  # private
  # def update_counts
  #   entry_type_name = entry_type.name
  #   if (EntryType.find(entry_type.parent_id).name == "Worklog")
  #     if(owner.worklog_counts[entry_type_name].present?)
  #       owner.worklog_counts[entry_type_name] += 1
  #     else
  #       owner.worklog_counts[entry_type_name] = 1
  #     end
  #   elsif (EntryType.find(entry_type.parent_id).name == "Feedback")
  #     if(owner.feedback_counts[entry_type_name].present?)
  #       owner.feedback_counts[entry_type_name] += 1
  #     else
  #       owner.feedback_counts[entry_type_name] = 1
  #     end
  #   end
  #   owner.save!
  # end
end
