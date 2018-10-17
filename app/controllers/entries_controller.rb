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

  private
  def entry_create_params
    params.require(:entry).permit(:sharing_level, :title, :description, :entry_type_id, content: {}, :tagged_user_ids => [], :shared_with => {})
  end

  # def validate_entry entry 
  #   errors = []
  #   version = entry[:version]
  #   entry_type_id = entry[:entry_type_id]
  #   byebug
  #   @entry_type = EntryType.find(entry_type_id)
  # end
end
