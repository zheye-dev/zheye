class AnswerCommentTest < ActiveSupport::TestCase
  test "should not save answercomment without answer" do
    comment = AnswerComment.new(content: "legal comment",user: users(:tester))
    assert_not comment.save
  end
end