class User < ActiveRecord::Base
    acts_as_authentic
    has_many :votes, dependent: :destroy
    has_many :questions, dependent: :destroy
    has_many :answers, dependent: :destroy
    has_many :comments, dependent: :destroy
end
