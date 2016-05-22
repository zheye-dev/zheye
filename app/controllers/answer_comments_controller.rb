class AnswerCommentsController < CommentsController
  # Display all comments to an answer
  def index
    @comments = AnswerComment.where(:answer => params[:answer_id])
  end
  # Action: Create a new comment to answer
  def create
    @comment = AnswerComment.create(question: question_id, answer: answer_id, content: comment_params)
  end

  # Display an comment box to current answer
  def new
    @answer_comment = AnswerComment.new
  end

  # Display form to edit current answer commenet
  def edit
    @comment = AnswerComment.update(comment_params)
    redirect_to root_path
  end

end
