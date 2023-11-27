class DigsController < ApplicationController
  before_action :set_dig, only: %i[ show edit update destroy ]
  before_action { authorize(@dig || Dig) }

  # GET /digs or /digs.json
  def index
    @q = current_user.digs.ransack(params[:q])
    @digs = @q.result(distinct: true)
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
    # primary_investigator = User.find_by(email: dig_params[:primary_investigator_email])

    respond_to do |format|
      # if primary_investigator
      #   new_params = dig_params.except(:primary_investigator_email)
      #   new_params[:primary_investigator_id] = primary_investigator.id
      @dig = Dig.new(dig_params)
      if @dig.save
        format.html { redirect_to dig_url(@dig), notice: "Dig was successfully created." }
        format.json { render :show, status: :created, location: @dig }
        DigParticipant.create(dig_id: @dig.id, participant: current_user, role: "lead")
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dig.errors, status: :unprocessable_entity }
      end
      # else
      #   format.html { redirect_to new_dig_url, status: :unprocessable_entity, notice: "User not found."}
      #   format.json { render json: { error: "User not found" }, status: :unprocessable_entity }
      # end
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
      params.require(:dig).permit(:start_date, :end_date, :location, :name, :description, :season, :artifact_count, :creator_id)
    end
end
