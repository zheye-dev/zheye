# Virtual class for comments, don't call directly
class CommentsController < ApplicationController
  layout false


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
    render 'destroy'
  end

end
