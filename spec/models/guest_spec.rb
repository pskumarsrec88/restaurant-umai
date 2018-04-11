require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Guest, type: :model do

  it 'has a valid factory' do
    expect(FactoryBot.create(:guest)).to be_valid
  end

  context 'associations' do
    it { should have_many(:reservations) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should allow_value('sample@test.com').for(:email) }
    it { should_not allow_value('sample').for(:email) }
  end
end