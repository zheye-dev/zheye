class AnswerVote < Vote
  validates_uniqueness_of :user_id, scope: :answer_id
  belongs_to :answer
end