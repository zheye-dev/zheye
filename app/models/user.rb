class User < ActiveRecord::Base
    acts_as_authentic
    has_many :votes, dependent: :destroy
    has_many :questions, dependent: :destroy
    has_many :answers, dependent: :destroy
    has_many :comments, dependent: :destroy

    def all_upvotes_received
        upvotes_count =
            self.questions.inject(0) do |count, q|
                count += q.question_votes.where(attitude: 1).length
            end
        self.answers.inject(upvotes_count) do |count, q|
            count += q.answer_votes.where(attitude: 1).length
        end

    end
end
