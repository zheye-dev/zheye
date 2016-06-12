class AnswersControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

  test "should get new" do
    get :new, question_id: questions(:tester_question).id
    assert_template 'new'
    assert_not_nil assigns(:answer)
  end

  test "should create answer" do
    post :create, format: 'js', question_id: questions(:del_tester_question).id, user: @current_user, answer: {content: "this is a legal content"}
    assert_template 'create'
  end

  test "shouldn't answer twice" do
    post :create, format: 'js', question_id: questions(:tester_question).id, user: @current_user, answer: {content: "this is a legal content"}
    assert_template '_errors'
  end

  test "shouldn't create answer whihout legal content" do
    post :create, format: 'js', question_id: questions(:tester_question).id, user: @current_user, answer: {content: "illegal"}
    assert_template '_errors'
  end

  test "shouldn't update answer without legal content" do
    post :update, question_id: questions(:tester_question).id, id: answers(:tester_answer).id, answer: {content: "ill"}
    assert_redirected_to question_path(assigns(:question))
  end

  #authorize
  test "admin should update answer" do
    auser = users(:admin)
    @controller.instance_eval do
      @current_user = auser
    end
    post :update, question_id: questions(:tester_question).id, id: answers(:tester_answer).id, answer: {content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "user should update his answer" do
    post :update, question_id: questions(:tester_question).id, id: answers(:tester_answer).id, answer: {content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
  end

  test "user shouldn't update other's answer" do
    assert_raise(CanCan::AccessDenied){post :update, question_id: questions(:tester_question).id, id: answers(:del_tester_answer).id, answer: {content: "this is a legal content"}}
  end

  test "admin should destroy answer" do
    auser = users(:admin)
    @controller.instance_eval do
      @current_user = auser
    end
    post :destroy, question_id: questions(:tester_question).id, id: answers(:tester_answer).id
    assert_redirected_to root_path
  end

  test "user shouldn't destroy his answer" do
    assert_raise(CanCan::AccessDenied){post :destroy, question_id: questions(:tester_question).id, id: answers(:tester_answer).id}
  end

  test "user shouldn't destroy other's answer" do
    assert_raise(CanCan::AccessDenied){post :destroy, question_id: questions(:tester_question).id, id: answers(:del_tester_answer).id}
  end
end
