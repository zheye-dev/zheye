class Answer < ActiveRecord::Base
    validates_length_of :content, minimum: 10, maximum: 2000
    validates_uniqueness_of :user_id, scope: :question_id
    belongs_to :user
    belongs_to :question
    has_many :answer_comments
    has_many :answer_votes
end
