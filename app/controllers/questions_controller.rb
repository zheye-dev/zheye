class QuestionsController < ApplicationController
  before_action :get_question, :only => [:show,:edit,:update,:destroy]
  authorize_resource
  # Action: Create a new comment to question
  def get_question
    @question = Question.find(params[:id])
  end
  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    authorize! :create, @question
    if @question.save
      redirect_to @question
    else
      render 'new'
    end

  end

  # Display an comment box to current question
  def show
  end

  def index
    @sort = params.fetch(:sort, '2')
    @sort_strategy = @sort == '1' ?
        QuestionsHelper::DateSortStrategy::new :
        QuestionsHelper::PrioritySortStrategy::new

    @questions = @sort_strategy.acquire_sorted

  end

  # Display form to edit current question comment
  def edit
    authorize! :update, @question
  end

  # Action: Update given question comment
  def update
    if @question.update(question_params)
      redirect_to @question
      flash[:notice] = 'Question updated!'
    else
      render 'edit'
      flash[:notice] = 'Failed!'
    end
  end

  # Action: Destroy current question
  # Require question.user == current_user.login || Admin access
  def destroy
    @question.destroy
    redirect_to root_path
  end
  private
  def question_params
    params.require(:question).permit(:title, :content)
  end
end
