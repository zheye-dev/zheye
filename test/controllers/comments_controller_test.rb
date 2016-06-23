class CommentsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    comment = comments(:tester_question_comment)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "user shouldn't destroy his comment" do
    assert_raise(CanCan::AccessDenied){post :destroy, format: 'js'}
  end
end
