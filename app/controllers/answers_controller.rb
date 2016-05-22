class AnswersController < ApplicationController

  # Display all answers to a question
  def index
    @answers = Answer.where(:question => params[:question_id])
  end

  # Action: Create a new answer
  def create
    @answer = Answer.create(question: question_id, user: current_user.id, content: answer_params)
    redirect_to root_path
  end

  # Display an answer box to current question
  def new
    @answer = Answer.new
  end

  # Display an item of answer
  def show
    @answer = Answer.find(params[:id])
  end

  # Display form to edit current answer
  def edit
    @answer = Answer.find(params[:id])
  end

  # Action: Update given answer
  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    redirect_to root_path
  end

  # Action: Destroy current answer
  # Require answer.id == current_user.login || admin access
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to root_path
  end
  private
  def answer_params
    params.require(:answer).permit(:text)
  end
end
