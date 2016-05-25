require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "destroy questionswhile user destroyed" do
    user = User.create(login: "tester", password: "password", password_confirmation: "password")
    question = user.questions.create(user: user, title:"test title", content: "this is a test question")
    assert_equal question.user,user

    user.destroy
    assert user.frozen?, "destroy user unsuccess"
    assert question.frozen?,"destroy question unsuccess"
  end

  test "destroy answers while user destroyed" do
    user = User.new(login: "tester", password: "password", password_confirmation: "password")
    user.save
    question = Question.create(user: user, title:"test title", content: "this is a test question")
    answer = Answer.create(question_id: question.id, user: user, content: "this is a test answer")
    assert_equal answer.user,user

    user.destroy
    assert user.frozen?, "destroy user unsuccess"
    assert answer.frozen?,"destroy answer unsuccess"
  end

  test "destroy comments while user destroyed" do
    user = User.new(login: "tester", password: "password", password_confirmation: "password")
    user.save
    question = Question.create(user_id: user.id, title:"test title", content: "this is a test question")
    comment = QuestionComment.create(question_id: question.id, user_id: user.id, content: "this is a test commont")
    assert_equal user.comments.first,comment

    user.destroy
    assert user.frozen?, "destroy user unsuccess"
    assert comment.frozen?,"destroy comment unsuccess"
  end
end
