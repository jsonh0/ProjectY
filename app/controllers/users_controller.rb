# app/controllers/users_controller.rb
class UsersController < Devise::RegistrationsController
  before_action :authenticate_user! # Add this if you want to ensure users are authenticated for these actions

  def index
    @q = User.ransack(params[:q])
    @users = @q.result
  end

  def show
    @user = User.find_by(username: params.fetch(:username))
  end
end
