class AnswerComment < Comment
  validates_presence_of :answer
  belongs_to :answer
end
