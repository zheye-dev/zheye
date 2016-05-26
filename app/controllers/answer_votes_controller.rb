class AnswerVotesController < ApplicationController
  authorize_resource
  def handle
    @vote = AnswerVote.find_or_initialize_by user: current_user, answer_id: params[:answer_id]
    @vote.attitude = answer_vote_params[:attitude]
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
    params.require(:answer_vote).permit(:attitude)
  end
end
