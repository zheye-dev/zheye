class QuestionVoteTest < ActiveSupport::TestCase
  test "one vote per question per user" do
    vote = QuestionVote.new(attitude: 1, user: users(:tester), question: questions(:tester_question))
    assert_not vote.save
  end
end