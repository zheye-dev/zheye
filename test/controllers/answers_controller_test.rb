require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "should create answer" do
    post :create, question_id: questions(:tester_question).id, user: @current_user, answer:  {content: "this is a legal content"}
    question = questions(:tester_question)
    assert_redirected_to question_path(question)
  end

  test "shouldn't create answer" do
    post :create, question_id: questions(:tester_question).id, user: @current_user, answer:  {content: "illegal"}
    assert_response :success
  end

  test "admin should update answer" do
    auser = users(:admin)
    @controller.instance_eval do
      @current_user = auser
    end
    post :update, question_id: questions(:tester_question).id, id: answers(:tester_answer).id, answer:  {content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "tester should update question" do
    post :update, question_id: questions(:tester_question).id, id: answers(:tester_answer).id, answer:  {content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "tester shouldn't update question" do
    post :update, question_id: questions(:tester_question).id, id: answers(:tester_answer).id, answer:  {content: "ill"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "admin should destroy question" do
    auser = users(:admin)
    @controller.instance_eval do
      @current_user = auser
    end
    post :destroy, question_id: questions(:tester_question).id, id: answers(:tester_answer).id
    assert_redirected_to root_path
  end
end
