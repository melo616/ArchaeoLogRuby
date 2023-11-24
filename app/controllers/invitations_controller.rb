class InvitationsController < ApplicationController
  before_action :set_invitation, only: %i[ accept destroy ]
  after_action :skip_pundit_authorization
  
  # GET /invitations or /invitations.json
  def index
    @pending_received_invitations = current_user.pending_received_invitations
    @pending_sent_invitations = current_user.pending_sent_invitations
  end

  # GET /invitations/new
  # def new
  #   @invitation = Invitation.new
  # end

  # POST /invitations or /invitations.json
  def create
    invitation_params = params.require(:invitation).permit(:dig_id, :participant_email, :role)
    participant_email = invitation_params[:participant_email]
    participant = User.find_by(email: participant_email)
    dig_id = invitation_params[:dig_id]
    dig = Dig.find(dig_id)
    respond_to do |format|
      if participant
        if dig.dig_participants.any? { |dig_participant| dig_participant.participant_id == participant.id}
          format.html { redirect_to dig_dig_participants_path(dig), status: :unprocessable_entity, notice: "User is already a participant of this dig."}
          format.json { render json: { error: "Participant already exists." }, status: :unprocessable_entity }
        else
          sender = current_user
          @invitation = Invitation.new(dig_id: invitation_params[:dig_id], recipient: participant, sender: sender, role: invitation_params[:role])
            if @invitation.save
              format.html { redirect_to root_path, notice: "Invitation was successfully sent." }
              format.json { render :show, status: :created, location: @invitation }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @invitation.errors, status: :unprocessable_entity }
            end
        end
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, notice: "User not found. Please verify user is registered with ArchaeoLog."}
        format.json { render json: { error: "User not found" }, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @invitation.status = "accepted"
    @invitation.save
    DigParticipant.create(dig_id: @invitation.dig_id, participant: current_user, role: @invitation.role)
  end

  # DELETE /invitations/1 or /invitations/1.json
  def destroy
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url, notice: "Invitation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invitation_params
      params.require(:invitation).permit(:role, :status, :dig_id, :sender_id, :recipient_id)
    end

    #for development only - DELETE
    def skip_pundit_authorization
      skip_authorization
      skip_policy_scope
    end
end
