class VoteTest < ActiveSupport::TestCase
  test "vote must have user" do
    vote = Vote.new(attitude: 1)
    assert_not vote.save
  end

  test "legal vote should be saved" do
    vote = Vote.new(attitude: 1, user: users(:tester))
    assert vote.save
  end

  test "illegal vote couldn't be saved" do
    vote = Vote.new(attitude: 0, user: users(:tester))
    assert_not vote.save
  end
end
