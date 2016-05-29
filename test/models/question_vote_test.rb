require 'test_helper'

class QuestionVoteTest < ActiveSupport::TestCase
  test "one vote per question per user" do
    vote1 = QuestionVote.new(attitude: -1, user: users(:tester), question: questions(:tester_question))
    assert vote1.save
    vote2 = QuestionVote.new(attitude: 1, user: users(:tester), question: questions(:tester_question))
    assert_not vote2.save
  end
end