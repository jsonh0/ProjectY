class AccessesController < ApplicationController
  before_action :set_access, only: %i[ show edit update destroy ]

  # GET /accesses or /accesses.json
  def index
    @q = Access.ransack(params[:q])

    # Check if search parameters are present
    if params[:q].present?
      # Apply the search if parameters are present
      @accesses = @q.result(distinct: true)
    else
      # If no search parameters, display all records or handle as needed
      @accesses = Access.all
    end
  
  end

  # GET /accesses/1 or /accesses/1.json
  def show
  end

  # GET /accesses/new
  def new
    @access = Access.new
  end

  # GET /accesses/1/edit
  def edit
  end

  def access_params
    params.require(:access).permit(:role, :account_id, :user_id) # Permit any other attributes as needed
  end

  # POST /accesses or /accesses.json
  def create
    @access = Access.new(access_params)

    respond_to do |format|
      if @access.save
        format.html { redirect_to access_url(@access), notice: "Access was successfully created." }
        format.json { render :show, status: :created, location: @access }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accesses/1 or /accesses/1.json
  def update
    respond_to do |format|
      if @access.update(access_params)
        format.html { redirect_to access_url(@access), notice: "Access was successfully updated." }
        format.json { render :show, status: :ok, location: @access }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accesses/1 or /accesses/1.json
  def destroy
    @access.destroy

    respond_to do |format|
      format.html { redirect_to accesses_url, notice: "Access was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_access
    @access = Access.find(params[:id])
  end

  # Only allow a list of trusted parameters through.

  def access_params
    params.require(:access).permit(:user_id, :account_id, :role, :other_permissible_attribute)
  end

end
