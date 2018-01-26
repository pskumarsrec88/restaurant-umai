class Reservation < ApplicationRecord
  # Associations
  belongs_to :restaurant
  belongs_to :guest
  belongs_to :table

  # nested attributes for shift
  accepts_nested_attributes_for :guest

  # Validations
  validates :reservation_time, :guest_count, presence: true
  validate :validate_reservation_time, unless: proc { |r| r.reservation_time.blank? }
  validate :validate_guest_count, unless: proc { |r| r.guest_count.blank? }

  # Callbacks
  after_create :send_notification_to_restaurant, :send_notification_to_guest
  after_update :send_update_notification_to_guest

  # delegates
  delegate :name, :email, to: :guest, prefix: true
  delegate :name, :email, to: :restaurant, prefix: true
  delegate :name, to: :table, prefix: true

  # Response object
  def to_json
    {
      reservation_time: reservation_time,
      guest_count: guest_count,
      guest_name: guest_name,
      table_name: table_name,
      created_at: created_at,
      table_namet: table_name
    }
  end

  private

    def validate_reservation_time
      errors.add(:reservation_time, 'must lie between restaurant start and end time') unless restaurant.shifts_available(reservation_time).any?
    end

    def validate_guest_count
      errors.add(:guest_count, 'must lie between minimum and maximum capacity of the table') unless guest_count.between?(table.minimum_capacity, table.maximum_capacity)
    end

    def send_notification_to_restaurant
      ReservationMailer.send_notification_to_restaurant(self).deliver_later
    end

    def send_notification_to_guest
      ReservationMailer.send_notification_to_guest(self).deliver_later
    end

    def send_update_notification_to_guest
      old_reservation_time = self.reservation_time_before_last_save
      old_guest_count = self.guest_count_before_last_save
      reservation = self.reload
      ReservationMailer.send_update_notification_to_guest(reservation, old_reservation_time.to_s, old_guest_count).deliver_later
    end
end
