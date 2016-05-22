class Comment < ActiveRecord::Base
    belongs_to :user
  validates_presence_of :user_id
  validates_length_of :content, minimum: 5, maximum: 200
end

class QuestionComment < Comment
    validates_presence_of :question
    belongs_to :question
end

class AnswerComment < Comment
    validates_presence_of :answer
    belongs_to :answer
end
