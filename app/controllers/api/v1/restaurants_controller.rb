class Api::V1::RestaurantsController < ApplicationController
  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: { success: true, message: 'Restaurant successfully created', restaurant: restaurant.to_json }
    else
      render json: { success: false, message: restaurant.errors }
    end
  end

  def index
    restaurants = Restaurant.all.includes(:shifts, :tables)
    render json: { success: true, restaurant: restaurants.map(&:to_json) }
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :email, :phone_number, shifts_attributes: [:start_time, :end_time], tables_attributes: [:name, :minimum_capacity, :maximum_capacity])
    end
end
