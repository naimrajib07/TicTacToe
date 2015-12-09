require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl::build(:game)).to be_valid
  end

  let(:game) { FactoryGirl::build(:game) }

  describe 'Active Model Validation' do
    it {  expect(game).to validate_presence_of(:player_1_name) }
    it {  expect(game).to validate_presence_of(:player_2_name) }
  end

  describe 'ActiveRecord Associations' do
    it { expect(game).to have_many(:boards) }
  end
end
