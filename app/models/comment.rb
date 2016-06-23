class Comment < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  validates_length_of :content, minimum: 5, maximum: 200

  after_create do |comment|
    old_score = comment.score
    comment.calculate_score
    if old_score != comment.score
      comment.save
    end
  end

  public
    def calculate_score
      logger.debug "comment calculate score start"
      self.score = user.score

      logger.debug "comment calculate score success"

      self.score
    end
end
