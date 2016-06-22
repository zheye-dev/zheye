class User < ActiveRecord::Base
    acts_as_authentic
    has_many :votes, dependent: :destroy
    has_many :questions, dependent: :destroy
    has_many :answers, dependent: :destroy
    has_many :comments, dependent: :destroy

    after_create :calculate_score
    after_update :calculate_score

    def all_upvotes_received
        upvotes_count =
            self.questions.inject(0) do |count, q|
                count += q.question_votes.where(attitude: 1).length
            end
        self.answers.inject(upvotes_count) do |count, q|
            count += q.answer_votes.where(attitude: 1).length
        end

    end

  def calculate_score
      logger.debug "user calculate score start"

      self.score = 0.0
      cnt = 0

      answers.order(score: :desc).each do |answer|
          cnt += 1
          self.score += answer.score
          break if cnt == 9
      end

      self.score += 1
      self.score /= 10

      logger.debug "user calculate score success"

      self.score

  end
end
