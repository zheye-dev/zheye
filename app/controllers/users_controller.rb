class UsersController < ApplicationController
  # Display all users
  # Require admin access
  def index

  end
  # Action: Create a new user
  # params.require(:user).permit(:login, :password, :password_confirmation)
  def create
    @user = User.new(users_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  # Display registeration form
  def new
    @user = User.new
  end

  # Display info about certain user
  def show

  end

  # Display form to edit current user's info
  def edit

  end

  # Action: Update given user's info
  def update

  end

  # Action: Destroy certain user(not logout)
  # Require admin access
  def destroy

  end

  private

  def users_params
    # Todo: Add other user info required by register here
    params.require(:user).permit(:login, :password, :password_confirmation)
  end

end
