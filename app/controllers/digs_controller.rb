class DigsController < ApplicationController
  before_action :set_dig, only: %i[ show edit update destroy ]

  # GET /digs or /digs.json
  def index
    @digs = Dig.all
  end

  # GET /digs/1 or /digs/1.json
  def show
  end

  # GET /digs/new
  def new
    @dig = Dig.new
  end

  # GET /digs/1/edit
  def edit
  end

  # POST /digs or /digs.json
  def create
    @dig = Dig.new(dig_params)

    respond_to do |format|
      if @dig.save
        format.html { redirect_to dig_url(@dig), notice: "Dig was successfully created." }
        format.json { render :show, status: :created, location: @dig }
        DigParticipant.create(dig_id: @dig.id, participant: current_user, role: "admin")
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /digs/1 or /digs/1.json
  def update
    respond_to do |format|
      if @dig.update(dig_params)
        format.html { redirect_to dig_url(@dig), notice: "Dig was successfully updated." }
        format.json { render :show, status: :ok, location: @dig }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /digs/1 or /digs/1.json
  def destroy
    @dig.destroy

    respond_to do |format|
      format.html { redirect_to digs_url, notice: "Dig was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dig
      @dig = Dig.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dig_params
      params.require(:dig).permit(:start_date, :end_date, :location, :name, :description, :season, :artifact_count, :creator_id, :primary_investigator_id)
    end
end
