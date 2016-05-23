# Virtual class for comments, don't call directly
class CommentsController < ApplicationController
  authorize_resource

  # Action: Update given comment
  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    flash[:notice] = 'Comment edited!'
  end

  # Action: Destroy current comment
  # Require comment.user == current_user.login || Admin access
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

end
