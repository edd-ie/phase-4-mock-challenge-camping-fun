class Activity < ApplicationRecord
    has_many :signups, dependent: :destroy
    has_many :campers, through: :signups

    validates :name, :difficulty, presence: :true
    validates :difficulty, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10
    }

    def camper
        x = Activity.find(params[:id])
        x.campers
    end
end
