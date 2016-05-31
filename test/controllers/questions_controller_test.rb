require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  #test "should get index" do
  #  get :index
  #  assert_response :success
  #end

  test "should create question" do
    post :create, question: {title: "this is a legal title", content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "shouldn't create question" do
    post :create, question: {title: "ill", content: "this is a legal content"}
    assert_response :success
  end

  test "admin should update question" do
    auser = users(:admin)
    @controller.instance_eval do
      @current_user = auser
    end
    post :update, id: questions(:tester_question).id  ,question: {title: "this is a legal title", content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "tester should update question" do
    post :update, id: questions(:tester_question).id  ,question: {title: "this is a legal title", content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "tester shouldn't update question with illegal title" do
    post :update, id: questions(:tester_question).id  ,question: {title: "ill", content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "admin should destroy question" do
    auser = users(:admin)
    @controller.instance_eval do
      @current_user = auser
    end
    post :destroy, id: questions(:tester_question).id
    assert_redirected_to root_path
  end

end
