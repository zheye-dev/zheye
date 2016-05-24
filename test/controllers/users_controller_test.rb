require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    user = User.first
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "should create user" do
    post :create, user: {login: "admin", password: "admin", password_confirmation: "admin"}
    assert_redirected_to root_path
  end

  test "shouldn't create user" do
    post :create, user: {login: "admin", password: "admin", password_confirmation: "adminn"}
    assert_response :success
  end

  test "should update user" do
    post :update, {id: users(:tester).id, user: {gender: true, realname: "tester", birthday: "1996-07-10", address: "test address", self_introduction: "hhh"}}
    assert_redirected_to user_path(assigns(:user))
  end


end
