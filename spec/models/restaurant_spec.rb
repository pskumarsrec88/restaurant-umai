require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Restaurant, type: :model do

  it 'has a valid factory' do
    expect(FactoryBot.create(:restaurant)).to be_valid
  end

  context 'associations' do
    it { should have_many(:shifts) }
    it { should have_many(:tables) }
    it { should have_many(:reservations) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
    it { should validate_presence_of(:email) }
    it { should allow_value('sample@test.com').for(:email) }
    it { should_not allow_value('sample').for(:email) }
    it { should validate_presence_of(:phone_number) }
    it { should allow_value('123 123 123 1234').for(:phone_number) }
    it { should_not allow_value('123456').for(:phone_number) }
  end

  context 'accept nested attributes' do
    it { should accept_nested_attributes_for(:shifts) }
    it { should accept_nested_attributes_for(:tables) }
  end

  context "instance methods" do
    it "validating json object" do
      expect(FactoryBot.build(:restaurant).to_json.length).to eq(8)
    end
  end
end