class Api::V1::ReservationsController < ApplicationController
  # filter to set reservation
  before_action :set_restaurant, only: %i(create index)
  before_action :set_reservation, only: %i(update)

  # reservation create
  def create
    reservation = @restaurant.reservations.build(reservation_params)
    if reservation.save
      render json: { success: true, message: 'Reservation successfully created', reservation: reservation.to_json }
    else
      render json: { success: false, message: reservation.errors }
    end
  end

  def index
    @reservations = @restaurant.reservations.includes(:guest, :table)
    render json: { success: true, reservations: @reservations.map(&:to_json) }
  end

  # reservation create
  def update
    if @reservation.update(reservation_params)
      render json: { success: true, message: 'Reservation successfully updated', reservation: @reservation }
    else
      render json: { success: false, message: @reservation.errors }
    end
  end

  private

    # filter method to set reservation
    def set_reservation
      @reservation = Reservation.find_by(id: params[:id])
    end

    def set_restaurant
      @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    end

    # Permit params
    def reservation_params
      params.require(:reservation).permit(:table_id, :reservation_time, :guest_count, guest_attributes: [:name, :email])
    end
end
