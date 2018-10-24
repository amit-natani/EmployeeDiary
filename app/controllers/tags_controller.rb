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

  def get_billing_head_list
    tag = Tag.where(name: 'Billing-Head').last
    if tag.present?
      values = tag.values.select { |value| value["leaf"] }
    else
      values = []
    end
    render json: values
  end

  def get_open_suggestions
    query = params[:query]
    values = Tag.where(name: 'Open').last.values
    tag_values = []
    values.each do |value|
      tag_values.push(value['value'])
    end
    tag_values = tag_values.grep(/#{query}/i)
    render json: tag_values
  end

  private
  def tag_params
    
  end
end
