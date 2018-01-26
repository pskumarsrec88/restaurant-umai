require 'rails_helper'
require 'support/factory_girl'

describe Api::V1::RestaurantsController, type: :controller do
  describe 'GET #index' do
    it 'renders the empty response' do
      get :index
      json = JSON.parse(response.body)
      expect(json['restaurant']).to be_empty
    end

    it 'renders the response' do
      FactoryBot.create(:restaurant)
      get :index
      json = JSON.parse(response.body)
      expect(json['restaurant']).not_to be_empty
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new Restaurant in the database' do
        params = { restaurant: FactoryBot.attributes_for(:restaurant).merge(shifts_attributes: [FactoryBot.attributes_for(:shift)]).merge(tables_attributes: [FactoryBot.attributes_for(:table)]) }
        post :create, params: params
        json = JSON.parse(response.body)
        expect(json['success']).to be true
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new Restaurant in the database' do
        params = { restaurant: FactoryBot.attributes_for(:restaurant).except(:name) }
        post :create, params: params
        json = JSON.parse(response.body)
        expect(json['success']).to be false
      end
    end
  end
end
