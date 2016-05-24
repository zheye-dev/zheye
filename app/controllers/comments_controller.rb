# Virtual class for comments, don't call directly
class CommentsController < ApplicationController
  layout false
  before_action :get_comment, :only => [:update,:destroy]
  authorize_resource
  def get_comment
    @comment = Comment.find(params[:id])
  end
  # Action: Update given comment
  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment edited!'
    else
      render 'comment/new'
    end
  end

  # Action: Destroy current comment
  # Require comment.user == current_user.login || Admin access
  def destroy
    @comment.destroy
    redirect_to root_path
  end

end
