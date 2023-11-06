class DigParticipantsController < ApplicationController
  before_action :set_dig
  before_action :set_dig_participant, only: %i[ show edit update destroy ]

  # GET /dig_participants or /dig_participants.json
  def index
    @dig_participants = DigParticipant.where(:dig_id => @dig.id)
  end

  # GET /dig_participants/1 or /dig_participants/1.json
  def show
  end

  # GET /dig_participants/new
  def new
    @dig_participant = DigParticipant.new
  end

  # GET /dig_participants/1/edit
  def edit
  end

  # POST /dig_participants or /dig_participants.json
  def create
    dig_participant_params = params.require(:dig_participant).permit(:participant_email, :role)
    participant_email = dig_participant_params[:participant_email]
    participant = User.find_by(email: participant_email)
    if participant
      @dig_participant = @dig.dig_participants.new(dig_id: @dig.id, participant: participant, role: dig_participant_params[:role])
    else
      # format.html { redirect_to :new, status: :unprocessable_entity, notice: "No user associated with this email found."}
      format.html { redirect_to(:action => "new", :notice => "No user associated with this email found.") }

      # format.json { render json: @dig_participant.errors, status: :unprocessable_entity }
    end

    respond_to do |format|
      if @dig_participant.save
        format.html { redirect_to dig_url(@dig), notice: "Dig participant was successfully created." }
        format.json { render :show, status: :created, location: @dig_participant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dig_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dig_participants/1 or /dig_participants/1.json
  def update
    respond_to do |format|
      if @dig_participant.update(dig_participant_params)
        format.html { redirect_to dig_dig_participants_url(@dig, @dig_participant), notice: "Dig participant was successfully updated." }
        format.json { render :show, status: :ok, location: @dig_participant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dig_participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dig_participants/1 or /dig_participants/1.json
  def destroy
    @dig_participant.destroy

    respond_to do |format|
      format.html { redirect_to dig_dig_participants_url, notice: "Dig participant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dig_participant
      @dig_participant = DigParticipant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dig_participant_params
      params.require(:dig_participant).permit(:dig_id, :participant_id, :role)
    end

    def set_dig
      @dig = Dig.find_by(id: params.fetch(:dig_id))
    end
end
