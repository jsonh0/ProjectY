class ForeignNationalsController < ApplicationController
  before_action :set_foreign_national, only: %i[ show edit update destroy ]

  # GET /foreign_nationals or /foreign_nationals.json
  def index
    @foreign_nationals = ForeignNational.all
  end

  # GET /foreign_nationals/1 or /foreign_nationals/1.json
  def show
  end

  # GET /foreign_nationals/new
  def new
    @foreign_national = ForeignNational.new
  end

  # GET /foreign_nationals/1/edit
  def edit
  end

  # POST /foreign_nationals or /foreign_nationals.json
  def create
    @foreign_national = ForeignNational.new(foreign_national_params)

    respond_to do |format|
      if @foreign_national.save
        format.html { redirect_to foreign_national_url(@foreign_national), notice: "Foreign national was successfully created." }
        format.json { render :show, status: :created, location: @foreign_national }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @foreign_national.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foreign_nationals/1 or /foreign_nationals/1.json
  def update
    respond_to do |format|
      if @foreign_national.update(foreign_national_params)
        format.html { redirect_to foreign_national_url(@foreign_national), notice: "Foreign national was successfully updated." }
        format.json { render :show, status: :ok, location: @foreign_national }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @foreign_national.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foreign_nationals/1 or /foreign_nationals/1.json
  def destroy
    @foreign_national.destroy

    respond_to do |format|
      format.html { redirect_to foreign_nationals_url, notice: "Foreign national was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foreign_national
      @foreign_national = ForeignNational.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def foreign_national_params
      params.require(:foreign_national).permit(:name, :status, :birthday, :address)
    end
end
