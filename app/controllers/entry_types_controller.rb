class EntryTypesController < ApplicationController
  def index
    @entry_types = EntryType.where(instantiable: true)
  end
  
  def get_custom_form
    id = params[:id]
    @entry_type = EntryType.find(id)
    if @entry_type.versions.present? && @entry_type.active_version.present?
      custom_fields = @entry_type.versions[@entry_type.active_version]
    end
    render json: {custom_fields: custom_fields}
  end

  def get_version_list
    id = params[:id]
    @entry_type = EntryType.find(id)
    render json: { keys: @entry_type.versions.keys }
  end
end
