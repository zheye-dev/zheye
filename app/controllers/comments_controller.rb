# Virtual class for comments, don't call directly
class CommentsController < ApplicationController

  # Display an item of comment
  def show

  end

  # Action: Update given comment
  def update

  end

  # Action: Destroy current comment
  # Require comment.user == current_user.login || Admin access
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to root_path
  end

end
