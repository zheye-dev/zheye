class QuestionCommentsController < CommentsController
  before_action :get_comment, :only => [:edit, :update, :destroy]
  authorize_resource

  respond_to :html, :js
  def get_comment
    @comment = QuestionComment.find(params[:id])
  end
  # Display all comments to a question
  def index
    @comments = QuestionComment.where(question_id: params[:question_id])
  end
  # Action: Create a new comment to question
  def create
    super
    @question = Question.find(params[:question_id])
    @comment = QuestionComment.new(question_comment_params)
    @comment.question = @question
    authorize! :create, @comment
    @comment.user = current_user
    @comment.save
  end

  # Display an comment box to current question
  def new
    @comment = QuestionComment.new
    @comment.question = Question.find(params[:question_id])
    #render 'comments/new'
  end

  # Display form to edit current question comment
  def edit
    authorize! :update, @comment
  end

  private
  def question_comment_params
    params.require(:question_comment).permit(:content)
  end
end