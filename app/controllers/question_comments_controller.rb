class QuestionCommentsController < CommentsController
  # Display all comments to a question
  def index
    @comments = QuestionComment.where(:answer => params[:answer_id])
  end
  # Action: Create a new comment to question
  def create
    @comment = QuestionComment.create(question: question_id, content: comment_params)
  end

  # Display an comment box to current question
  def new
    @comment = QuestionComment.new
  end

  # Display form to edit current question commenet
  def edit
    @comment = QuestionComment.update(comment_params)
    redirect_to root_path
  end
end