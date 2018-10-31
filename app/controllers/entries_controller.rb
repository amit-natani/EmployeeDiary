class EntriesController < ApplicationController
  def index
    @entries = Entry.all
  end

  def create
    @entry = Entry.new(entry_create_params)
    @entry.set_default_params
    if @entry.valid?
      @entry.save!
      render json: @entry, status: :created
    else
      render json: @entry.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @entry = Entry.find_by_id(params[:id])
    render json: @entry, status: :ok
  end
  
  def update
    @entry = Entry.update(entry_create_params)
    if @entry.valid?
      render json: @entry, status: :ok
    else
      render json: @entry.errors.full_messages, status: :unprocessable_entity
    end
  end

  def change_approval_status
    @entry = Entry.find(params[:id])
    @entry.status = params[:status]
    if @entry.valid?
      @entry.save!
      render json: @entry, status: :ok
    else
      render json: @entry.errors.full_messages, status: :unprocessable_entity
    end
  end

  def get_all_worklogs
    worklog_entry_type = EntryType.where(name: 'Worklog').last;
    worklog_sub_enty_ids = EntryType.where(parent_id: worklog_entry_type.id).map(&:id)
    @worklogs = Entry.in(entry_type_id: worklog_sub_enty_ids)
  end

  def get_worklog_counts
    to_date = params[:to_date]
    from_date = params[:from_date]
    entries = Entry.where(owner_id: current_user.id).group_by(&:entry_type_id)
    counts = format_worklog_entries entries
    render json: counts
  end

  def get_feedback_counts
    entries = Entry.where(owner_id: current_user.id).group_by(&:entry_type_id)
    counts = format_feedback_entries entries
    render json: counts
  end

  def get_all_feedbacks
    feedback_entry_type = EntryType.where(name: 'Feedback').last;
    feedback_sub_enty_ids = EntryType.where(parent_id: feedback_entry_type.id).map(&:id)
    @feedbacks = Entry.in(entry_type_id: feedback_sub_enty_ids)
  end

  def get_entries_by_entry_type_id
    @entries = Entry.where(entry_type_id: params[:id], owner_id: current_user.id)
    render :index
  end

  def get_type_specific_worklogs
    types = params[:types]
    entry_type_ids = EntryType.in(name: types).map(&:id);
    @entries = Entry.in(entry_type_id: entry_type_ids)
    render :index
  end

  def get_type_specific_feedbacks
    types = params[:types]
    entry_type_ids = EntryType.in(name: types).map(&:id);
    @entries = Entry.in(entry_type_id: entry_type_ids)
    render :index
  end

  private
  def entry_create_params
    params.require(:entry).permit(:sharing_level, :title, :description, :entry_type_id, content: {}, :tagged_user_ids => [], :shared_with => {})
  end

  def format_worklog_entries entries
    counts = {}
    entries.each do |key, value|
      entry_type = EntryType.find(key)
      if(EntryType.find(entry_type.parent_id).name == 'Worklog')
        counts[entry_type.name] = value.count
      end
    end
    counts
  end

  def format_feedback_entries entries
    counts = {}
    entries.each do |key, value|
      entry_type = EntryType.find(key)
      if(EntryType.find(entry_type.parent_id).name == 'Feedback')
        counts[entry_type.name] = value.count
      end
    end
    counts
  end

  # def validate_entry entry 
  #   errors = []
  #   version = entry[:version]
  #   entry_type_id = entry[:entry_type_id]
  #   byebug
  #   @entry_type = EntryType.find(entry_type_id)
  # end
end
