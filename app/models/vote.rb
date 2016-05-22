class Vote < ActiveRecord::Base
    validates_presence_of :user
    validates_inclusion_of :attitude, in: [-1, 1]
    belongs_to :user
end
