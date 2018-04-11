require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Reservation, type: :model do

  describe 'associations' do
    it { should belong_to(:restaurant) }
    it { should belong_to(:guest) }
    it { should belong_to(:table) }
  end

  describe 'validations' do
    it { should validate_presence_of(:reservation_time) }
    it { should validate_presence_of(:guest_count) }
  end

  describe "instance methods" do
    it "validating json object" do
      @restaurant = FactoryBot.create(:restaurant)
      @shift = FactoryBot.create(:shift, restaurant_id: @restaurant.id)
      @table = FactoryBot.create(:table, restaurant_id: @restaurant.id)
      @reservation = Reservation.create(FactoryBot.attributes_for(:reservation).merge(restaurant_id: @restaurant.id).merge(table_id: @table.id).merge(guest_attributes: FactoryBot.attributes_for(:guest)))
      expect(@reservation.to_json.length).to eq(6)
    end
  end
end