class AnswersController < ApplicationController
  before_action :get_answer, :only => [:update,:show,:edit,:destroy]
  before_action :get_question, :only => [:index,:create,:new,:update,:show,:edit,:destroy]
  authorize_resource

  layout false
  # Display all answers to a question
  def get_answer
    @answer = Answer.find(params[:id])
  end
  def get_question
    @question = Question.find(params[:question_id])
  end
  def index
    @answers = Answer.where(question: @question)
  end

  # Action: Create a new answer
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question
    authorize! :create, @answer
    if @answer.save
      redirect_to @question
      flash[:notice] = 'answer added'
    else
      render 'new'
      flash[:notice] = 'Failed!'
    end
  end

  # Display an answer box to current question
  def new
    @answer = Answer.new
  end

  # Display an item of answer
  def show
  end

  # Display form to edit current answer
  def edit
    authorize! :update, answer
  end

  # Action: Update given answer
  def update
    @answer.update(answer_params)
    redirect_to @question
  end

  # Action: Destroy current answer
  # Require answer.id == current_user.login || admin access
  def destroy
    @answer.destroy
    redirect_to root_path
  end
  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
