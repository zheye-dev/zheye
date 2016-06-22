class Comment < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  validates_length_of :content, minimum: 5, maximum: 200

  before_save :calculate_score
  after_update :calculate_score

  def calculate_score
    logger.debug "comment calculate score start"
    self.score = user.score

    logger.debug "comment calculate score success"

    self.score
  end
end
