class AnswerVoteTest < ActiveSupport::TestCase
  test "one vote per question per user" do
    vote = AnswerVote.new(attitude: 1, user: users(:tester), answer: answers(:tester_answer))
    assert_not vote.save
  end
end