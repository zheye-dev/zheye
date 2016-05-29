class QuestionTest < ActiveSupport::TestCase
  test "should save question" do
    question = Question.new(title: "legal title", content: "legal comment",user_id: 1)
    assert question.save
  end

  test "should not save question with illegal title" do
    question = Question.new(title: "ill", content: "legal comment",user_id: 1)
    assert_not question.save
  end

  test "question must have user" do
    question = Question.new(title: "legal title", content: "legal comment")
    assert_not question.save
  end
end
