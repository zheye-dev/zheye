class AnswerComment < Comment
  validates_presence_of :answer
  belongs_to :answer

  def chain
    [self.answer.question, self.answer, self]
  end

end
