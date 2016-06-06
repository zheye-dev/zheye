class CommentTest < ActiveSupport::TestCase
  test "should save comment" do
    answer = Answer.new(content: "legal content",user: users(:tester))
    assert answer.save
  end

  test "should not save comment with illegal content" do
    answer = Answer.new(content: "four",user: users(:tester))
    assert_not answer.save
  end

  test "comment must have user" do
    answer = Answer.new(content: "legal content")
    assert_not answer.save
  end
end
