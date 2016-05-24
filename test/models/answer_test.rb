require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test "should not save answer without title" do
    answer = Answer.new
    assert_not answer.save
  end

  test "should not save answer with illegal length" do
    answer = Answer.new(content: "only nine",user_id: 1)
    assert_not answer.save
  end

  test "should not save answer without user" do
    answer = Answer.new(content: "legal content")
    assert_not answer.save
  end

  test "should not save two answers from one user" do
    answer = Answer.new(content: "legal content",question_id: 519995637, user_id: 1011897928)
    assert_not answer.save
  end

end
