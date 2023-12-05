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
    @q = current_user.accounts.ransack(params[:q])
    if params[:q].present? 
      if current_user.admin?
        @q1 = Account.ransack(params[:q])
        @q2 = ForeignNational.ransack(params[:q])
        @results = @q1.result + @q2.result
      else
        @results = current_user.accounts.ransack(params[:q]).result
      end
      respond_to do |format|
        format.html { render 'shared/search' }
        format.json { render json: @accounts }
      end
    end
  end
  
end
