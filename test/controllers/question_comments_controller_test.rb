require 'test_helper'

class QuestionCommentsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "should get new" do
    get :new, question_id: questions(:tester_question).id
    assert_not_nil assigns(:comment)
  end

  test "should get index" do
    get :index, question_id: questions(:tester_question).id
    assert_not_nil assigns(:comments)
  end

  #need json
  test "shouldn't create question comment" do
    post :create, {question_id: questions(:tester_question).id, user: @current_user, question_comment: {content: "ill"}}
    assert_response :success
  end

  #authorize
  test "admin should update comment" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    get :get_comment, id: comments(:tester_question_comment).id
    post :update, answer_comment: {content: "legal content"}
    assert_equal flash[:notice], 'Comment edited!'
  end

  test "user should update his comment" do
    get :get_comment, id: comments(:tester_question_comment).id
    post :update, question_comment: {content: "legal content"}
    assert_equal flash[:notice], 'Comment edited!'
  end

  test "user shouldn't update other's comment" do
    get :get_comment, id: comments(:del_tester_question_comment).id
    assert_raise(CanCan::AccessDenied){post :update, question_comment: {content: "legal content"}}
  end

  test "admin should destroy comment" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    get :destroy, id: comments(:tester_question_comment).id
    assert_template 'destroy'
  end

  test "user shouldn't destroy his comment" do
    assert_raise(CanCan::AccessDenied){get :destroy, id: comments(:tester_question_comment).id}
  end

  test "user shouldn't destroy other's comment" do
    assert_raise(CanCan::AccessDenied){get :destroy, id: comments(:del_tester_question_comment).id}
  end
end
