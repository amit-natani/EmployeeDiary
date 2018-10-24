class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def get_users
    query = params[:query]
    users = User.where(first_name: /^#{query}/i)
    user_names = []
    users.each do |user|
      user_names.push(user.first_name + ' ' +user.last_name)
    end
    render json: user_names
  end
end
