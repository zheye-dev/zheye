require 'sanitize'
class Question < ActiveRecord::Base
    validates_presence_of :user_id
    validates_length_of :content, maximum: 1000
    validates_length_of :title, minimum: 5, maximum: 50
    belongs_to :user
    has_many :answers
    has_many :question_comments
    has_many :question_votes

  before_save :sanitize_content
  before_update :sanitize_content

  private

  def sanitize_content
    self.content = Sanitize.fragment(self.content, Sanitize::Config::RELAXED)
  end
end