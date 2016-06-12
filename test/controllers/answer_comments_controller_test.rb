class AnswerCommentsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  #authorize
  test "admin should update comment" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    post :update, id: comments(:tester_answer_comment).id, answer_comment: {content: "legal content"}
    assert_equal flash[:notice], 'Comment edited!'
  end

  test "user should update his comment" do
    post :update, id: comments(:tester_question_comment).id, question_comment: {content: "legal content"}
    assert_equal flash[:notice], 'Comment edited!'
  end

  test "user shouldn't update other's comment" do
    assert_raise(CanCan::AccessDenied){post :update, id: comments(:del_tester_question_comment).id, question_comment: {content: "legal content"}}
  end

  test "admin should destroy comment" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    post :destroy, format: 'js',id: comments(:tester_answer_comment).id
    assert_template 'destroy'
  end

  test "user shouldn't destroy his comment" do
    assert_raise(CanCan::AccessDenied){post :destroy, format: 'js',id: comments(:tester_answer_comment).id}
  end

  test "user shouldn't destroy other's comment" do
    assert_raise(CanCan::AccessDenied){post :destroy, format: 'js',id: comments(:del_tester_question_comment).id}
  end
end
