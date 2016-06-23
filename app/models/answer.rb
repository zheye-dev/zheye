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

    after_create :calculate_score

    after_find do |answer|
      old_score = answer.score
      answer.calculate_score
      if old_score != answer.score
        answer.save
      end
    end

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

    public
      def calculate_score
          logger.debug "answer calculate score start"
          u = Float(answer_votes.where(attitude: 1).length)
          v = Float(answer_votes.where(attitude: -1).length)
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

        comment_score = 0.0
        cnt = 0

        answer_comments.order(score: :desc).each do |comment|
            next if comment.user_id == self.user_id
            cnt += 1
            comment_score += comment.score
            break if cnt == 100
        end

        comment_score /= 100

        begin
            date_diff = (DateTime.now - created_at).to_i
        rescue
            date_diff = 0
        end

        self.score = vote_score * 0.7 + comment_score * 0.3

        if date_diff < 10
            self.score += 0.02 * (10 - date_diff)
        end

        logger.debug "answer calculate score success"

        self.score
      end
end
