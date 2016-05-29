class AnswerVoteTest < ActiveSupport::TestCase
  test "one vote per question per user" do
    vote1 = AnswerVote.new(attitude: 1, user: users(:tester), answer: answers(:tester_answer))
    assert vote1.save
    vote2 = AnswerVote.new(attitude: -1, user: users(:tester), answer: answers(:tester_answer))
    assert_not vote2.save
  end
end