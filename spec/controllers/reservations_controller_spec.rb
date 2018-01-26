require 'rails_helper'
require 'support/factory_girl'

describe Api::V1::ReservationsController, type: :controller do
  before :each do
    @restaurant = FactoryBot.create(:restaurant)
    @shift = FactoryBot.create(:shift, restaurant_id: @restaurant.id)
    @table = FactoryBot.create(:table, restaurant_id: @restaurant.id)
  end

  describe 'GET #index' do
    it 'renders the empty response' do
      get :index, params: { restaurant_id: @restaurant.id }
      json = JSON.parse(response.body)
      expect(json['reservations']).to be_empty
    end

    it 'renders the response' do
      FactoryBot.create(:reservation, restaurant_id: @restaurant.id, table_id: @table.id, guest_id: FactoryBot.create(:guest).id)
      get :index, params: { restaurant_id: @restaurant.id }
      json = JSON.parse(response.body)
      expect(json['reservations']).not_to be_empty
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new Restaurant in the database' do
        params = { restaurant_id: @restaurant.id, reservation: FactoryBot.attributes_for(:reservation).merge(table_id: @table.id).merge(guest_attributes: FactoryBot.attributes_for(:guest)) }
        post :create, params: params
        json = JSON.parse(response.body)
        expect(json['success']).to be true
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new reservation in the database' do
        params = { restaurant_id: @restaurant.id, reservation: FactoryBot.attributes_for(:reservation).merge(table_id: @table.id) }
        post :create, params: params
        json = JSON.parse(response.body)
        expect(json['success']).to be false
      end
    end
  end
end
