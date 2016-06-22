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
  before_save :calculate_score
  before_update :calculate_score


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
    logger.debug "question calculate score start"
    u = Float(question_votes.where(attitude: 1).length)
    v = Float(question_votes.where(attitude: -1).length)
    n = u + v

    vote_score = 0.0

    if (n != 0)
      p = u / n
      z = 1.96

      vote_score = 4 * n * (1 - p) * p + z ** 2
      vote_score = Math.sqrt(vote_score)
      vote_score = vote_score * z / n / 2
      vote_score = p + z ** 2 / 2 / n - vote_score
      vote_score = vote_score / (1 + z ** 2 / n)
    end

    answer_score = 0.0
    cnt = 0

    answers.order(score: :desc).each do |answer|
      cnt += 1
      answer_score += answer.score
      break if cnt == 99
    end

    begin
      date_diff = DateTime.now - DateTime.parse(created_at.to_s)
    rescue
      date_diff = 0
    end

    self.score = vote_score * 0.3 + answer_score * 0.7

    if date_diff < 10
      self.score += 0.02 * (10 - date_diff)
    end

    logger.debug "question calculate score success"

    self.score

  end
end