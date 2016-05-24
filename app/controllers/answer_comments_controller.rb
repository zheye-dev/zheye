class AnswerCommentsController < CommentsController
  # Display all comments to an answer
  def index
    @comments = AnswerComment.where(answer_id: params[:answer_id])
  end
  # Action: Create a new comment to answer
  def create
    @comment_parent = Answer.find(params[:answer_id])
    @comment = AnswerComment.new(question_id: @comment_parent.question_id, answer: @comment_parent, user: current_user, content: answer_comment_params[:content])
    if @comment.save
      redirect_to @comment.answer.question
    else
      render 'comment/new'
    end
  end

  # Display an comment box to current answer
  def new
    @comment = AnswerComment.new
    @comment.answer = Answer.find(params[:answer_id])
    #render 'comments/new'
  end

  # Display form to edit current answer comment
  def edit
    @comment = AnswerComment.find(params[:answer_comment_id])
    authorize! :update, @comment
  end
  private
  def answer_comment_params
    params.require(:answer_comment).permit(:content)
  end
end
