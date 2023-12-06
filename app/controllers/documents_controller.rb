class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]

  # GET /documents or /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1 or /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents or /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to request.referer || foreign_national_url(params[immigration_case_id]), notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render redirect_to request.referer || foreign_national_url(params[immigration_case_id]), status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def sent
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.name.blank? && @document.image.nil?
        @document.immigration_case.update(status: ImmigrationCase.statuses.keys[2])
        @document.immigration_case.update(sent_date: params[:document][:immigration_case][:sent_date])
        format.html { redirect_to request.referer || foreign_national_url(params[immigration_case_id]), notice: "Marked as Sent" }
      elsif @document.save
        @document.immigration_case.update(status: ImmigrationCase.statuses.keys[2])
        @document.immigration_case.update(sent_date: params[:document][:immigration_case][:sent_date])
        format.html { redirect_to request.referer || foreign_national_url(params[immigration_case_id]), notice: "Document was successfully created. Marked as Sent" }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { redirect_to request.referer || foreign_national_url(params[immigration_case_id]), status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_receipt
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.extracted_text.blank?
        format.html { redirect_to request.referer || foreign_national_url(params[immigration_case_id]), status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      elsif @document.save
        @document.immigration_case.update(status: ImmigrationCase.statuses.keys[3])
        @document.immigration_case.update(received_date: params[:document][:immigration_case][:received_date])
        @document.immigration_case.update(receipt_number: params[:document][:extracted_text])
        format.html { redirect_to request.referer || foreign_national_url(params[immigration_case_id]), notice: "Document was successfully created. Added Receipt" }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render redirect_to request.referer || foreign_national_url(params[immigration_case_id]), status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1 or /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to document_url(@document), notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1 or /documents/1.json
  def destroy
    id = @document.immigration_case.id
    @document.destroy

    respond_to do |format|
      format.html { redirect_to immigration_case_path(id), notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document).permit(:immigration_case_id, :name, :image, :extracted_text, :uploader_id, immigration_case_attributes: [:sent_date])
  end
end
