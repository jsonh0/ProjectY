class ForeignNationalsController < ApplicationController
  before_action :set_foreign_national, only: %i[ show edit update destroy ]

  # GET /foreign_nationals or /foreign_nationals.json
  def index

    @foreign_nationals = if current_user.admin?
      @q = ForeignNational.ransack(params[:q])
      @ForeignNational = @q.result
    else
      current_user.ForeignNational
    end
    
  end

  # GET /foreign_nationals/1 or /foreign_nationals/1.json
  def show
    @foreign_national = ForeignNational.find(params[:id])
    @foreign_national_id = @foreign_national.id
    @account_id = @foreign_national.account_id
  end

  # GET /foreign_nationals/new
  def new
    @foreign_national = ForeignNational.new
    @account_id = params[:account_id]

    
  end

  # GET /foreign_nationals/1/edit
  def edit
    @account_id = @foreign_national.account_id

  end

  # POST /foreign_nationals or /foreign_nationals.json
  def create
    puts "Params: #{params.inspect}"
    @foreign_national = ForeignNational.new(foreign_national_params)
    @account_id = params[:account_id]
    respond_to do |format|
      if @foreign_national.save
        format.html { redirect_to account_path(@foreign_national.account_id), notice: "Foreign national was successfully created." }
        format.json { render :show, status: :created, location: @foreign_national }
        
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @foreign_national.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /foreign_nationals/1 or /foreign_nationals/1.json
  def update
    @account_id = @foreign_national.account_id
    respond_to do |format|
      if @foreign_national.update(foreign_national_params)
        format.html { redirect_to foreign_national_url(@foreign_national), notice: "Foreign national was successfully updated." }
        format.json { render :show, status: :ok, location: @foreign_national }
      else
        flash.now[:alert] = "Error updating foreign national. Please check the form."

        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @foreign_national.errors, status: :unprocessable_entity }
  
      end
    end
  end
  

  # DELETE /foreign_nationals/1 or /foreign_nationals/1.json
  def destroy
    account_id @foreign_national.account_id
    @foreign_national.immigration_cases.each do |immigration_case|
      immigration_case.document.each do |doc|
        doc.destroy
      end

      immigration_case.destroy

    end
    @foreign_national.destroy
    respond_to do |format|
      format.html { redirect_to foreign_nationals_url, notice: "Foreign national was successfully destroyed." }
      format.json { head :no_content }
    end
    redirect_to account_path(account_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foreign_national
      @foreign_national = ForeignNational.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def foreign_national_params
      params.require(:foreign_national).permit(:name, :status, :birthday, :address, :account_id)
    end
end
