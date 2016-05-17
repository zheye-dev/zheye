class Question < ActiveRecord::Base
    belongs_to :user
    has_many :answers
    has_many :question_comments
    has_many :question_votes
end
