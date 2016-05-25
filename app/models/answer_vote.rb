class AnswerVote < Vote
  validates_uniqueness_of :user_id, scope: :answer_id
  belongs_to :answer

  def chain
    [self.answer.question, self.answer, self]
  end
end