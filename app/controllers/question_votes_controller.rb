class QuestionVotesController < VotesController

  def index
    @vote = QuestionVote.find_or_initialize_by user: current_user, question_id: params[:question_id]
    if !@vote.persisted?
      @vote.attitude = 0
    end
  end

  def handle
    @vote = QuestionVote.find_or_initialize_by user: current_user, question_id: params[:question_id]
    @vote_id = question_vote_params[:vote_id]
    @vote.attitude = question_vote_params[:question_vote][:attitude]
    if @vote.attitude == 0
      authorize! :destroy, @vote
      @vote.destroy
    else
      authorize! :create, @vote
      @vote.save
    end
  end

  private
  def question_vote_params
    params.permit(:vote_id, question_vote: :attitude)
  end
end
