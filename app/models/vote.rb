class Vote < ActiveRecord::Base
    validates_presence_of :user
    validates_inclusion_of :attitude, in: [-1, 1]
    belongs_to :user
end

class QuestionVote < Vote
    validates_uniqueness_of :user_id, scope: :question_id
    belongs_to :question
end

class AnswerVote < Vote
    validates_uniqueness_of :user_id, scope: :answer_id
    belongs_to :answer
end
