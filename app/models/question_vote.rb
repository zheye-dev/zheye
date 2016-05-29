require 'test_helper'

class QuestionVote < Vote
  validates_uniqueness_of :user_id, scope: :question_id
  belongs_to :question

  def chain
    [self.question, self]
  end

  def points
    QuestionVote.where(question: self.question).sum(:attitude)
  end

  def self.user_vote(user, question_id)
    vote = QuestionVote.find_or_initialize_by user: user, question_id: question_id
    if !vote.persisted?
      vote.attitude = 0
    end
    return vote
  end
end
