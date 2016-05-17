class Vote < ActiveRecord::Base
    belongs_to :user
end

class QuestionVote < Vote
    belongs_to :question
end

class AnswerVote < Vote
    belongs_to :answer
end
