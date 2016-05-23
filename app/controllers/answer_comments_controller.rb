class AnswerCommentsController < CommentsController
  # Display all comments to an answer
  def index
    @comments = AnswerComment.where(answer_id: params[:answer_id])
  end
  # Action: Create a new comment to answer
  def create
    @comment = AnswerComment.create(question: question_id, answer: answer_id, user_id: current_user, content: comment_params)
  end

  # Display an comment box to current answer
  def new
    @comment = AnswerComment.new
  end

  # Display form to edit current answer comment
  def edit
    @comment = AnswerComment.update(comment_params)
    redirect_to root_path
  end

end
