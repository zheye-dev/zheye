class QuestionVotesController < ApplicationController
  authorize_resource
  def create
    @vote = QuestionVote.find_or_initialize_by user: current_user, question_id: params[:question_id]
    @vote.attitude = question_vote_params[:attitude]
    @vote.save
  end

  private
  def question_vote_params
    params.require(:question_vote).permit(:attitude)
  end
end
