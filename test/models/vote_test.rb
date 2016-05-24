require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "vote must have user" do
    vote = Vote.new(attitude: 1)
    assert_not vote.save
  end
end
