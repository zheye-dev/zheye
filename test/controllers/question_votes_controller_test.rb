require 'test_helper'

class QuestionVotesControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "index" do
    post :get, question_id: questions(:tester_question)
    assert_response :success
    assert @vote.persisted?
  end
end
