require 'test_helper'

class QuestionCommentsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "shouldn't create question comment" do
    post :create, {question_id: questions(:tester_question).id, user: @current_user, question_comment: {content: "ill"}}
    assert_response :success
  end
end
