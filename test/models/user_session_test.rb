class UserSessionTest < ActiveSupport::TestCase

  test "should login" do
    user_session = UserSession.new(login: "administer", password: "password")
    user_session.save
    assert_equal user_session.errors.full_messages, []
  end

  test "shouldn't login with wrong passwrod" do
    user_session = UserSession.new(login: "administer", password: "wrongpassword")
    user_session.save
    assert_equal user_session.errors.full_messages, ["Password is not valid"]
  end

  test "shouldn't login with unexisted login" do
    user_session = UserSession.new(login: "unexist", password: "wrongpassword")
    user_session.save
    assert_equal user_session.errors.full_messages, ["Login is not valid"]
  end
end