class AnswerVotesController < VotesController

  def index
    @vote = AnswerVote.find_or_initialize_by user: current_user, answer_id: params[:answer_id]
    if !@vote.persisted?
      @vote.attitude = 0
    end
  end

  def handle
    @vote = AnswerVote.find_or_initialize_by user: current_user, answer_id: params[:answer_id]
    @vote_id = answer_vote_params[:vote_id]
    @vote.attitude = answer_vote_params[:answer_vote][:attitude]
    if @vote.attitude == 0
      authorize! :destroy, @vote
      @vote.destroy
    else
      authorize! :create, @vote
      @vote.save
    end
  end

  private
  def answer_vote_params
    params.permit(:vote_id, answer_vote: :attitude)
  end
end
