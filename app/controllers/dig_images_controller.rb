class DigImagesController < ApplicationController
  before_action :set_dig
  before_action :set_dig_image, only: %i[ show edit update destroy ]
  after_action :skip_pundit_authorization

  # GET /dig_images or /dig_images.json
  def index
    @dig_images = DigImage.all
  end

  # GET /dig_images/1 or /dig_images/1.json
  def show
  end

  # GET /dig_images/new
  def new
    @dig_image = DigImage.new
  end

  # GET /dig_images/1/edit
  def edit
  end

  # POST /dig_images or /dig_images.json
  def create
    @dig_image = DigImage.new(dig_image_params)

    respond_to do |format|
      if @dig_image.save
        format.html { redirect_to dig_dig_image_url(@dig, @dig_image), notice: "Dig image was successfully created." }
        format.json { render :show, status: :created, location: @dig_image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dig_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dig_images/1 or /dig_images/1.json
  def update
    respond_to do |format|
      if @dig_image.update(dig_image_params)
        format.html { redirect_to dig_image_url(@dig_image), notice: "Dig image was successfully updated." }
        format.json { render :show, status: :ok, location: @dig_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dig_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dig_images/1 or /dig_images/1.json
  def destroy
    @dig_image.destroy

    respond_to do |format|
      format.html { redirect_to dig_images_url, notice: "Dig image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dig_image
      @dig_image = DigImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dig_image_params
      params.require(:dig_image).permit(:image_url, :notes, :dig_id, :user_id)
    end

    def set_dig
      @dig = Dig.find(params.fetch(:dig_id))
    end

    #for development only - DELETE
    def skip_pundit_authorization
      skip_authorization
      skip_policy_scope
    end
end
