class AnswerTest < ActiveSupport::TestCase
  test "should save answer" do
    answer = Answer.new(content: "legal cotent",user: users(:tester))
    assert answer.save
  end

  test "should not save answer without content" do
    answer = Answer.new
    assert_not answer.save
  end

  test "should not save answer with illegal length" do
    answer = Answer.new(content: "only nine",user: users(:tester))
    assert_not answer.save
  end

  test "should not save answer without user" do
    answer = Answer.new(content: "legal content")
    assert_not answer.save
  end

  test "should not save two answers from one user" do
    answer = Answer.new(content: "legal content",question: questions(:tester_question), user: users(:tester))
    assert_not answer.save
  end

end
