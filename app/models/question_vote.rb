class QuestionVote < Vote
  validates_uniqueness_of :user_id, scope: :question_id
  belongs_to :question

  def chain
    [self.question, self]
  end
end
