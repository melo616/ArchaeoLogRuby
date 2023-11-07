class ArtifactsController < ApplicationController
  before_action :set_artifact, only: %i[ show edit update destroy ]

  # GET /artifacts or /artifacts.json
  def index
    @artifacts = Artifact.all
  end

  # GET /artifacts/1 or /artifacts/1.json
  def show
  end

  # GET /artifacts/new
  def new
    @artifact = Artifact.new
  end

  # GET /artifacts/1/edit
  def edit
  end

  # POST /artifacts or /artifacts.json
  def create
    @artifact = Artifact.new(artifact_params)

    respond_to do |format|
      if @artifact.save
        format.html { redirect_to artifact_url(@artifact), notice: "Artifact was successfully created." }
        format.json { render :show, status: :created, location: @artifact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artifacts/1 or /artifacts/1.json
  def update
    respond_to do |format|
      if @artifact.update(artifact_params)
        format.html { redirect_to artifact_url(@artifact), notice: "Artifact was successfully updated." }
        format.json { render :show, status: :ok, location: @artifact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artifact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artifacts/1 or /artifacts/1.json
  def destroy
    @artifact.destroy

    respond_to do |format|
      format.html { redirect_to artifacts_url, notice: "Artifact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artifact
      @artifact = Artifact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artifact_params
      params.require(:artifact).permit(:lat, :lng, :description, :material, :mohs_hardness, :weight, :dig_id, :site, :poster_id)
    end
end
