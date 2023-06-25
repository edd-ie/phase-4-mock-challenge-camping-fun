class Signup < ApplicationRecord
    belongs_to :camper
    belongs_to :activity

    validates :camper_id, :activity_id, :time, presence: true
    validates :time, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 23
    }
end
