class QuestionTest < ActiveSupport::TestCase
  test "should save question" do
    question = Question.new(title: "legal title", content: "legal question",user: users(:tester))
    assert question.save
  end

  test "should not save question with illegal title" do
    question = Question.new(title: "ill", content: "legal question",user: users(:tester))
    assert_not question.save
  end

  test "question must have user" do
    question = Question.new(title: "legal title", content: "legal question")
    assert_not question.save
  end
end
