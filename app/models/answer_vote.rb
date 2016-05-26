class AnswerVote < Vote
  validates_uniqueness_of :user_id, scope: :answer_id
  belongs_to :answer

  def chain
    [self.answer.question, self.answer, self]
  end

  def points
    AnswerVote.where(answer: self.answer).sum(:attitude)
  end

  def self.user_vote(user, answer_id)
    vote = AnswerVote.find_or_initialize_by user: user, answer_id: answer_id
    if !vote.persisted?
      vote.attitude = 0
    end
    return vote
  end
end