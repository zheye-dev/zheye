class QuestionsControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
    @user = user
  end

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
    assert_equal flash[:notice], 'Question updated!'
  end

  test "tester should update question" do
    post :update, id: questions(:tester_question).id  ,question: {title: "this is a legal title", content: "this is a legal content"}
    assert_redirected_to question_path(assigns(:question))
    assert_equal flash[:notice], 'Question updated!'
  end

  test "tester should update others question" do
    post :update, id: questions(:del_tester_question).id  ,question: {title: "this is a legal title", content: "this is a legal content"}
    assert_throws AccessDenied
  end

  test "tester shouldn't update question with illegal title" do
    post :update, id: questions(:tester_question).id  ,question: {title: "ill", content: "this is a legal content"}
    assert_template 'edit'
    assert_equal flash[:notice], 'Failed!'
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
