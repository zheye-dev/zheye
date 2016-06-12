class AnswerVotesControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "should get index" do
    get :index, answer_id: params[464091718]
    assert_not_nil assigns(:vote)
  end
end
