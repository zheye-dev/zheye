class QuestionCommentsController < CommentsController
  # Display all comments to a question
  def index
    #@comment_parent = Question.find(params[:question_id])
    @comments = QuestionComment.where(question_id: params[:question_id])
  end
  # Action: Create a new comment to question
  def create
    @comment_parent = Question.find(params[:question_id])
    if @comment = QuestionComment.create(question: @comment_parent, user: current_user, content: question_comment_params[:content])
     redirect_to @comment_parent
    else
      render 'comment/edit'
    end
  end

  # Display an comment box to current question
  def new
    @comment = QuestionComment.new
    @comment_parent = Question.find(params[:question_id])
    #render 'comments/new'
  end

  # Display form to edit current question comment
  def edit
    @comment = QuestionComment.find(params[:question_comment_id])
    authorize! :update, @comment
  end

  private
  def question_comment_params
    params.require(:question_comment).permit(:content)
  end
end