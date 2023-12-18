class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]
  before_action(except: [:new, :create]) { authorize(@image || Image ) }

  # GET /images/1 or /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = authorize Image.new(imageable_id: params[:imageable_id], imageable_type: params[:imageable_type])
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image =  authorize Image.new(image_params)
    respond_to do |format|
      if @image.save
        format.html { redirect_to image_url(@image), notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to image_url(@image), notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to image_redirect_path, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:image, :notes, :imageable_type, :imageable_id, :poster_id)
    end

    # Handles redirect on destroy
    def image_redirect_path
      if @image.imageable_type == "Dig"
        dig_url(@image.imageable)
      elsif @image.imageable_type == "Artifact"
        dig_artifact_url(@image.imageable.dig, @image.imageable)
      else
        root_url
      end
    end

end
