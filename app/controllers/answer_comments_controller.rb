class AnswerCommentsController < CommentsController
  # Display all comments to an answer
  def index
    @comments = AnswerComment.where(answer_id: params[:answer_id])
  end
  # Action: Create a new comment to answer
  def create
    @comment_parent = Answer.find(params[:answer_id])
    @comment = AnswerComment.create(question_id: @comment_parent.question_id, answer: @comment_parent, user: current_user, content: answer_comment_params[:content])
    if @comment
      redirect_to @comment_parent
    else
      render 'comments/edit'
    end
  end

  # Display an comment box to current answer
  def new
    @comment = AnswerComment.new
    @comment_parent = Answer.find(params[:answer_id])
    #render 'comments/new'
  end

  # Display form to edit current answer comment
  def edit
    @comment = AnswerComment.update(comment_params)
    redirect_to root_path
  end
  private
  def answer_comment_params
    params.require(:answer_comment).permit(:content)
  end
end
