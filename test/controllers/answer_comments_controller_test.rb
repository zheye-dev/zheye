require 'test_helper'

class AnswerCommentsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "should create comment" do
    post :create, format: 'js', answer_id: answers(:tester_answer).id, user: @current_user, answer_comment: {content: 'legal content'}
    assert_response :success
  end

  #authorize
  test "admin should update comment" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    post :update, answer_comment: {content: "legal content"}
    assert_equal flash[:notice], 'Comment edited!'
  end

  test "user should update his comment" do
    post :update, id: comments(:tester_answer_comment).id, answer_comment: {content: "legal content"}
    assert_equal flash[:notice], 'Comment edited!'
  end

  test "user shouldn't update other's comment" do
    assert_raise(CanCan::AccessDenied){post :update, id: comments(:del_tester_answer_comment).id, answer_comment: {content: "legal content"}}
  end

  test "admin should destroy comment" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    post :destroy, format: 'js'
    assert_template 'destroy'
  end

  test "user shouldn't destroy his comment" do
    assert_raise(CanCan::AccessDenied){post :destroy, format: 'js',id: comments(:tester_answer_comment).id}
  end

  test "user shouldn't destroy other's comment" do
    assert_raise(CanCan::AccessDenied){post :destroy, format: 'js',id: comments(:del_tester_answer_comment).id}
  end
end
