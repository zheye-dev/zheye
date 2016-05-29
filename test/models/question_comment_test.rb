class QuestionCommentTest < ActiveSupport::TestCase
  test "should not save questioncomment without question" do
    comment = QuestionComment.new(content: "legal comment",user: users(:tester))
    assert_not comment.save
  end
end