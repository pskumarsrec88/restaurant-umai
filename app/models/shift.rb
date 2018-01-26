class Shift < ApplicationRecord
  # Associations
  belongs_to :restaurant

  # Validations
  validates :start_time, :end_time, presence: true
  validate :start_must_be_before_end_time, unless: proc { |r| r.start_time.blank? && r.start_time.blank? }

  def shifts_available(time)
    time_converter(time).between?(time_converter(start_time), time_converter(end_time))
  end

  private

    def start_must_be_before_end_time
      errors.add(:end_time, 'can’t be less then the start time') unless start_time < end_time
    end

    def time_converter(time)
      Time.parse(time.strftime('%T'))
    end
end
