class DocumentsController < ApplicationController
  before_action :set_dig
  before_action :set_document, only: %i[ show edit update destroy ]
  after_action :skip_pundit_authorization

  # GET /documents or /documents.json
  def index
    @documents = Document.where(:dig_id => @dig.id)
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
        format.html { redirect_to dig_document_url(@document), notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
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
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    def set_dig
      @dig = Dig.find(params.fetch(:dig_id))
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:title, :author, :document_file, :notes, :poster_id, :dig_id, :allowed_roles => [])
    end

    def skip_pundit_authorization
      skip_authorization
      skip_policy_scope
    end
end
