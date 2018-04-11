require 'rails_helper'
require 'support/factory_girl'

RSpec.describe Shift, type: :model do

  context 'associations' do
    it { should belong_to(:restaurant) }
  end

  context 'validations' do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
  end
end