class QuestionsController < ApplicationController
  authorize_resource
  # Action: Create a new comment to question
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to @question
    else
      render 'new'
    end

  end

  # Display an comment box to current question
  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.all
  end

  # Display form to edit current question comment
  def edit
    @question = Question.find(params[:id])
    authorize! :update, @question
  end

  # Action: Update given question comment
  def update
    @question = Question.find(params[:id])
    authorize! :update, @question
    @question.update(question_params)
    redirect_to @question
  end

  # Action: Destroy current question
  # Require question.user == current_user.login || Admin access
  def destroy
    @question = Question.find(params[:id])
    authorize! :destroy, @question
    @question.destroy
    redirect_to root_path
  end
  private
  def question_params
    params.require(:question).permit(:title, :content)
  end
end
