class UsersControllerTest < ActionController::TestCase
  setup do
    user = users(:tester)
    @controller.instance_eval do
      @current_user = user
    end
  end

  test "should create user" do
    post :create, :format => 'js', user: {login: "tester2", password: "admin", password_confirmation: "admin"}
    assert_template 'create'
  end

  test "should get user's questions" do
    post :all_questions, id: users(:tester).id
    assert_not_nil assigns(:questions)
  end

  test "should get user's answers" do
    post :all_answers, id: users(:tester).id
    assert_not_nil assigns(:answers)
  end

  test "should get user's comments" do
    post :all_comments, id: users(:tester).id
    assert_not_nil assigns(:comments)
  end

  test "should get user's upvotes" do
    post :all_upvotes, id: users(:tester).id
    assert_not_nil assigns(:upvotes)
  end

  test "should get user's downvotes" do
    post :all_downvotes, id: users(:tester).id
    assert_not_nil assigns(:downvotes)
  end

  test "should get new" do
    get :new
    assert_template 'new'
    assert_not_nil assigns(:user)
  end

  test "should open show" do
    post :show, id: users(:tester).id
    assert_template 'show'
    assert_not_nil assigns(:user)
  end

  test "should open edit" do
    post :edit, id: users(:tester).id
    assert_template 'edit'
    assert_not_nil assigns(:user)
  end

  #authorize
  test "admin should update user" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    post :update, {id: users(:tester).id, user: {gender: true, realname: "tester", birthday: "1996-07-10", address: "test address", self_introduction: "hhh"}}
    assert_redirected_to user_path(assigns(:user))
  end

  test "should update user" do
    post :update, {id: users(:tester).id, user: {gender: true, realname: "tester", birthday: "1996-07-10", address: "test address", self_introduction: "hhh"}}
    assert_redirected_to user_path(assigns(:user))
  end

  test "shouldn't destroy user" do
    assert_raise(CanCan::AccessDenied){post :destroy, id: users(:tester).id}
  end

  test "admin should destroy user" do
    user = users(:admin)
    @controller.instance_eval do
      @current_user = user
    end
    post :destroy, id: users(:tester).id
    assert_redirected_to root_path
  end
end
