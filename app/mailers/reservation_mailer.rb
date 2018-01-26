class ReservationMailer < ApplicationMailer
  def send_notification_to_restaurant(reservation)
    @reservation = reservation
    mail(to: @reservation.guest_email, subject: 'New reservation booked')
  end

  def send_notification_to_guest(reservation)
    @reservation = reservation
    mail(to: @reservation.restaurant_email, subject: 'Reservation successfully created')
  end

  def send_update_notification_to_guest(reservation, old_reservation_time, old_guest_count)
    @reservation = reservation
    @old_reservation_time = old_reservation_time
    @old_guest_count = old_guest_count
    mail(to: @reservation.restaurant_email, subject: 'Reservation successfully modified')
  end
end
