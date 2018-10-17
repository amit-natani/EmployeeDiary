class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def create
    @tag = tag.new(tag_params)
  end

  def values
    id = params[:id]
    values = Tag.find(id).values
    render json: values
  end

  def get_project_list
    values = Tag.where(name: 'Project').first.values
    render json: values
  end

  private
  def tag_params
    
  end
end
