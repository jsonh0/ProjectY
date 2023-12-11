# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result
  end
  def show
    @user = User.find_by(username: params.fetch(:username))
  end


end
