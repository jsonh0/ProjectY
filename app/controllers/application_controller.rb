class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :admin])
  end
  
  def search
    if params[:q].present? # Check if search parameters are present
      if current_user.admin?
        @q = Account.ransack(params[:q])
        @accounts = @q.result
      else
        @accounts = current_user.accounts.ransack(params[:q])
      end

      respond_to do |format|
        format.html { render 'accounts/search' }
        format.json { render json: @accounts }
      end
    else
      @q = current_user.accounts.ransack(params[:q])
    end
  end
  
end
