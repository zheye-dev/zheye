class User < ActiveRecord::Base
    act_as_authentic
    has_many :votes
    has_many :questions
    has_many :answers
    has_many :comments
end
