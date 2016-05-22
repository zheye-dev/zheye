class AnswersController < ApplicationController

  # Display all answers to a question
  def index
    @answers = Answer.where(:question => params[:question_id])
  end

  # Action: Create a new answer
  def create

  end

  # Display an answer box to current question
  def new

  end

  # Display an item of answer
  def show

  end

  # Display form to edit current answer
  def edit

  end

  # Action: Update given answer
  def update

  end

  # Action: Destroy current answer
  # Require answer.id == current_user.login || admin access
  def destroy

  end
end
