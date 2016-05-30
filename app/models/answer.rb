class Answer < ActiveRecord::Base
    validates_length_of :content, minimum: 10, maximum: 2000
    validates_presence_of :user_id
    validates_uniqueness_of :user_id, scope: :question_id
    belongs_to :user
    belongs_to :question
    has_many :answer_comments, dependent: :destroy
    has_many :answer_votes, dependent: :destroy

    before_save :sanitize_content
    before_update :sanitize_content
    after_update :calculate_score

    searchable do
        text :content, :stored => true
    end

    def points
        AnswerVote.where(answer: self).sum(:attitude)
    end

    private

    def sanitize_content
        self.content = Sanitize.fragment(self.content, Sanitize::Config::RELAXED)
    end

    def calculate_score
        u = Float(answer_votes.where(attitude: 1).length)
        v = Float(answer_votes.where(attitude: -1).length)
        n = u + v

        if (n == 0)
            self.score = 0.0
            return nil
        end

        p = u / n
        z = 1.96

        self.score = 4 * n * (1 - p) * p + z ** 2
        self.score = Math.sqrt(self.score)
        self.score = self.score * z / n / 2
        self.score = p + z ** 2 / 2 / n - self.score
        self.score = self.score / (1 + z ** 2 / n)
        return nil
    end
end
