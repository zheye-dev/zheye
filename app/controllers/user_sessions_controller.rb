class UserSessionsController < ApplicationController

  # Display page of a new session(login page)
  def new
    @user_session = UserSession.new
  end

  # Action: Create a new session(login)
  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      redirect_to root_path
    else
      render :new
    end
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
