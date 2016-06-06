class UserSessionsController < ApplicationController

  layout 'simple'
  respond_to :html, :js
  # Display page of a new session(login page)
  def new
    @user_session = UserSession.new
  end

  # Action: Create a new session(login)
  def create
    @user_session = UserSession.new(user_session_params)
    @user_session.save
  end

  # Action: destroy current session(logout)
  def destroy
    current_user_session.destroy
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:login, :password, :remember_me)
  end

end
