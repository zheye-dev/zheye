require 'sanitize'
class Question < ActiveRecord::Base
  validates_presence_of :user_id
  validates_length_of :content, maximum: 1000
  validates_length_of :title, minimum: 5, maximum: 50
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_comments, dependent: :destroy
  has_many :question_votes, dependent: :destroy

  before_save :sanitize_content
  before_update :sanitize_content
  after_update :calculate_score


  searchable do
    string :title, :stored => true
    text :content, :stored => true
  end

  def points
    QuestionVote.where(question: self).sum(:attitude)
  end


  private

  def sanitize_content
    self.content = Sanitize.fragment(self.content, Sanitize::Config::RELAXED)
  end

  public

  def calculate_score
    u = Float(question_votes.where(attitude: 1).length)
    v = Float(question_votes.where(attitude: -1).length)
    n = u + v

    if (n == 0)
      self.score = 0.0
      return self.score
    end

    p = u / n
    z = 1.96

    self.score = 4 * n * (1 - p) * p + z ** 2
    self.score = Math.sqrt(self.score)
    self.score = self.score * z / n / 2
    self.score = p + z ** 2 / 2 / n - self.score
    self.score = self.score / (1 + z ** 2 / n)
    self.score
  end
end