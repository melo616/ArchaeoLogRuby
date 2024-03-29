class ArtifactsController < ApplicationController
  before_action :set_dig
  before_action :set_artifact, only: %i[ show edit update destroy ]
  before_action(except: [:new, :create, :artifacts_by_category, :artifacts_by_day]) { authorize(@artifact || Artifact) }

  # GET /artifacts or /artifacts.json
  def index
    @q = Artifact.where(:dig_id => @dig.id).page(params[:page]).per(10).ransack(params[:q])
    @artifacts = @q.result
  end

  # Data visualization
  def artifacts_by_category
    artifact_counts = Artifact.where(dig_id: @dig.id).group(:category).count
    humanized_counts = artifact_counts.transform_keys{ |category| category.to_s.humanize}
    render json: humanized_counts
  end

  def artifacts_by_day
    render json: Artifact.where(dig_id: @dig.id).group_by_day(:found_date).count
  end

  # GET /artifacts/1 or /artifacts/1.json
  def show
  end

  # GET /artifacts/new
  def new
    @artifact = current_user.created_artifacts.new
    @artifact.dig = @dig
    authorize @artifact
  end

  # GET /artifacts/1/edit
  def edit
  end

  # POST /artifacts or /artifacts.json
  def create
    @artifact = current_user.created_artifacts.new(artifact_params)
    @artifact.dig = @dig
    authorize @artifact
    respond_to do |format|
      if @artifact.save
        format.html { redirect_to dig_artifact_url(@dig, @artifact), notice: "Artifact was successfully created." }
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
        format.html { redirect_to dig_artifact_url(@dig, @artifact), notice: "Artifact was successfully updated." }
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
      format.html { redirect_to dig_artifacts_url(@dig), notice: "Artifact was successfully destroyed." }
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
    params.require(:artifact).permit(:description, :material, :category, :mohs_hardness, :weight, :dig_id, :site, :found_date)
  end

  def set_dig
    @dig = Dig.find(params.fetch(:dig_id))
  end
end
