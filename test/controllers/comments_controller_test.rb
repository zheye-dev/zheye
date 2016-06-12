class CommentsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "user shouldn't destroy his comment" do
    assert_raise(CanCan::AccessDenied){get :destroy, format: 'js', id: comments(:tester_question_comment).id}
  end
end
