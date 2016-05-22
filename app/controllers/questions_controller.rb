class QuestionsController < ApplicationController
  # Action: Create a new comment to question
  def new
    question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @root_path
    else
      flash[:notice] = "Not successful!"
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
  
  # Display form to edit current question commenet
  def edit

  end

  # Action: Update given question comment
  def update

  end

  # Action: Destroy current question
  # Require question.user == current_user.login || Admin access
  def destroy

  end
end
