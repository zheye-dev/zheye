class AnswersController < ApplicationController
  before_action :get_answer, :only => [:update,:show,:edit,:destroy]
  authorize_resource
  # Display all answers to a question
  def get_answer
    @answer = Answer.find(params[:id])
  end
  def index
    @question = Question.find(params[:question_id])
    @answers = Answer.where(question: @question)
  end

  # Action: Create a new answer
  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.create(question_id: @question.id, user: current_user, content: answer_params[:content])
    if @answer
     redirect_to Question.find(params[:question_id])
    else
      render 'new'
    end

  end

  # Display an answer box to current question
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  # Display an item of answer
  def show
    @question = Question.find(params[:question_id])
  end

  # Display form to edit current answer
  def edit
    authorize! :update, @answer
    @question = Question.find(params[:question_id])
  end

  # Action: Update given answer
  def update
    @question = Question.find(params[:question_id])
    @answer.update(answer_params)
    redirect_to @question
  end

  # Action: Destroy current answer
  # Require answer.id == current_user.login || admin access
  def destroy
    @question = Question.find(params[:question_id])
    @answer.destroy
    redirect_to root_path
  end
  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
