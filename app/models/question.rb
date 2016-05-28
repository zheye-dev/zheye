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


  searchable do
    string :title
    text :content
  end

  def points
    QuestionVote.where(question: self).sum(:attitude)
  end


  private

  def sanitize_content
    self.content = Sanitize.fragment(self.content, Sanitize::Config::RELAXED)
  end
end