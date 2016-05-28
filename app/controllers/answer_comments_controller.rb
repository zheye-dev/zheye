class AnswerCommentsController < CommentsController
  before_action :get_comment, :only => [:edit, :update, :destroy]
  layout false
  respond_to :html, :js
  authorize_resource
  def get_comment
    @comment = AnswerComment.find(params[:id])
  end
  # Display all comments to an answer
  def index
    @comments = AnswerComment.where(answer_id: params[:answer_id])
  end
  # Action: Create a new comment to answer
  def create
    super
    #@question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])
    @comment = AnswerComment.new(answer_comment_params)
    @comment.answer = @answer
    authorize! :create, @comment
    @comment.user = current_user
    @comment.save
  end

  # Display an comment box to current answer
  def new
    @comment = AnswerComment.new
    @comment.answer = Answer.find(params[:answer_id])
  end

  # Display form to edit current answer comment
  def edit
    authorize! :update, @comment
  end

  private
  def answer_comment_params
    params.require(:answer_comment).permit(:content)
  end
end
