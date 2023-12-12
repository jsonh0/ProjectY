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


  def extract_text
    img = RTesseract.new(params[:image].tempfile.path)
  
    begin
      text = img.to_s
      #it just works#
      receipt_number_match = text.match(/\n([A-Z]{3}.*?\d{5})\n/)
      notice_date_match = text.match(/\n([A-Za-z]+\s\d{1,2},\s\d{4})\n/)
  
      if receipt_number_match
        extracted_receipt_number = receipt_number_match[1].gsub(" ", "-")
      else
        extracted_receipt_number = "No match for receipt number."
      end
  
      if notice_date_match
        extracted_notice_date = notice_date_match[1]
        extracted_notice_date = Date.strptime(extracted_notice_date, "%b %d, %Y")

      else
        extracted_notice_date = "No match for notice date."
      end
  
    rescue StandardError => e
      extracted_receipt_number = "Error extracting receipt number: #{e.message}"
      extracted_notice_date = "Error extracting notice date: #{e.message}"
    end
  
    render json: { receipt_number: extracted_receipt_number, notice_date: extracted_notice_date }
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
    #img = RTesseract.new(@document.image.path)
    #txt = img.to_s
    
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

  def approved
    @document = Document.new(document_params)
    respond_to do |format|
      if  @document.save
        @document.immigration_case.update(status: ImmigrationCase.statuses.keys[5])
        @document.immigration_case.update(approval_date: params[:document][:immigration_case][:approval_date])
        @document.immigration_case.update(expiration_date: params[:document][:immigration_case][:expiration_date])
        if @document.immigration_case.case_type == ImmigrationCase.case_types.keys[1]
          @document.immigration_case.fn.update(status: ForeignNational.statuses.keys[3])
        end
        if @document.immigration_case.case_type == ImmigrationCase.case_types.keys[5]
          @document.immigration_case.fn.update(status: ForeignNational.statuses.keys[4])
        
        end
        format.html { redirect_to request.referer || foreign_national_url(params[immigration_case_id]), notice: "Document was successfully created. Case Approved" }
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
    params.require(:document).permit(:immigration_case_id, :name, :image, :extracted_text, :uploader_id, immigration_case_attributes: [:sent_date, :approval_date, :expiration_date])
  end
end
