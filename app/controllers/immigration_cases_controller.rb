class ImmigrationCasesController < ApplicationController
  before_action :set_immigration_case, only: %i[ show edit update destroy ]

  # GET /immigration_cases or /immigration_cases.json
  def index
    @immigration_cases = ImmigrationCase.all
  end

  # GET /immigration_cases/1 or /immigration_cases/1.json
  def show
    
  end

  # GET /immigration_cases/new
  def new
    @immigration_case = ImmigrationCase.new




  end

  # GET /immigration_cases/1/edit
  def edit
    @foreign_national = @immigration_case.foreign_nationals_id
  end

  # POST /immigration_cases or /immigration_cases.json
  def create
 
    @immigration_case = ImmigrationCase.new(immigration_case_params)
    @immigration_case.status = 0
    respond_to do |format|
      if @immigration_case.save
        format.html { redirect_to account_path(@immigration_case.fn.account_id), notice: "Immigration case was successfully created." }
        format.json { render :show, status: :created, location: @immigration_case }

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @immigration_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /immigration_cases/1 or /immigration_cases/1.json
  def update
    respond_to do |format|
      if @immigration_case.update(immigration_case_params)
        format.html { redirect_to immigration_case_url(@immigration_case), notice: "Immigration case was successfully updated." }
        format.json { render :show, status: :ok, location: @immigration_case }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @immigration_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /immigration_cases/1 or /immigration_cases/1.json
  def destroy
    @immigration_case.destroy

    respond_to do |format|
      format.html { redirect_to immigration_cases_url, notice: "Immigration case was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_immigration_case
      @immigration_case = ImmigrationCase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def immigration_case_params
      params.require(:immigration_case).permit(:ForeignNational_id, :case_type, :status, :ReceiptNumber, :NoticeDate, :ExpirationDate, :foreign_nationals_id)
    end
end
