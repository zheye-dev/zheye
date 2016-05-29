require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should save comment" do
    answer = Answer.new(content: "legal comment",user_id: 1)
    assert answer.save
  end

  test "should not save comment with illegal content" do
    answer = Answer.new(content: "four",user_id: 1)
    assert_not answer.save
  end

  test "comment must have user" do
    answer = Answer.new(content: "legal comment")
    assert_not answer.save
  end
end
