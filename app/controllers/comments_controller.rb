# Virtual class for comments, don't call directly
class CommentsController < ApplicationController

  # Display an item of comment
  def show
  end

  # Action: Update given comment
  def update

    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render 'Comment editted!'
    else
      render 'edit'
    end
  end

  # Action: Destroy current comment
  # Require comment.user == current_user.login || Admin access
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end
  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
