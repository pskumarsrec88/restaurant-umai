require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Table, type: :model do

  context 'associations' do
    it { should have_many(:reservations) }
    it { should belong_to(:restaurant) }

  end

  context 'validations' do
    it { should validate_presence_of(:minimum_capacity) }
    it { should validate_presence_of(:maximum_capacity) }
  end
end