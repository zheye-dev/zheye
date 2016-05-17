class Comment < ActiveRecord::Base
    belongs_to :user
end

class QuestionComment < Comment
    belongs_to :question
end

class AnswerComment < Comment
    belongs_to :answer
end
