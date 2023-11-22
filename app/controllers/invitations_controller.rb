class InvitationsController < ApplicationController
  before_action :set_dig
  before_action :set_invitation, only: %i[ show edit update destroy ]
  after_action :skip_pundit_authorization
  
  # GET /invitations or /invitations.json
  def index
    @received_invitations = current_user.received_invitations
    @sent_invitations = current_user.sent_invitations
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # POST /invitations or /invitations.json
  def create
  invitation_params = params.require(:invitation).permit(:participant_email, :role)
  participant_email = invitation_params[:participant_email]
  participant = User.find_by(email: participant_email)
    respond_to do |format|
      if participant
        sender = current_user
        @invitation = @dig.invitations.new(dig_id: @dig.id, recipient: participant, sender: sender, role: invitation_params[:role])
          if @invitation.save
            format.html { redirect_to dig_invitations_url(@dig), notice: "Invitation was successfully sent." }
            format.json { render :show, status: :created, location: @invitation }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @invitation.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to dig_url(@dig), status: :unprocessable_entity, notice: "User not found. Please verify user is registered with ArchaeoLog."}
          format.json { render json: { error: "User not found" }, status: :unprocessable_entity }
      end
    end
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

    def set_dig
      @dig = Dig.find(params.fetch(:dig_id))
    end

    #for development only - DELETE
    def skip_pundit_authorization
      skip_authorization
      skip_policy_scope
    end
end
