class QuestionCommentsController < CommentsController
  # Display all comments to a question
  def index
    @comments = QuestionComment.where(answer_id: params[:answer_id])
  end
  # Action: Create a new comment to question
  def create
    @comment = QuestionComment.create(question: question_id, user: current_user, content: comment_params)
  end

  # Display an comment box to current question
  def new
    @comment = QuestionComment.new
    @comment_parent = Question.find(params[:question_id])
    render 'comments/new'
  end

  # Display form to edit current question comment
  def edit
    @comment = QuestionComment.update(comment_params)
    redirect_to root_path
  end
end