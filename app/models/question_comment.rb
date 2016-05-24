class QuestionComment < Comment
  validates_presence_of :question
  belongs_to :question

  def chain
    [self.question, self]
  end

end
