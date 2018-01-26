class Table < ApplicationRecord
  # Associations
  has_many :reservations
  belongs_to :restaurant

  # Validations
  validates :minimum_capacity, :maximum_capacity, presence: true
  validate :minimum_must_be_less_then_maximum_capacity, unless: proc { |r| r.minimum_capacity.blank? && r.maximum_capacity.blank? }

  private

    def minimum_must_be_less_then_maximum_capacity
      errors.add(:maximum_capacity, 'can’t be less then the minimum capacity') unless minimum_capacity < maximum_capacity
    end
end
