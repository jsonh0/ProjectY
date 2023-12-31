# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user! # Add this if you want to ensure users are authenticated for these actions

  def index
    @q = User.ransack(params[:q])
    @users = @q.result
  end

  def show
    @user = User.find_by(username: params.fetch(:username))
  end
end

#when i deploy heroku and zeitwerk was asking for user_controller so i duplicated it 
