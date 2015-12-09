require 'rails_helper'

RSpec.describe Board, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl::build(:board)).to be_valid
  end

  let(:board) { FactoryGirl::build(:board) }

  describe 'Active Model Validation' do
    it {  expect(board).to validate_presence_of(:game_id) }
    it {  expect(board).to validate_presence_of(:current_player) }
  end

  describe 'ActiveRecord Associations' do
    it { expect(board).to belong_to(:game) }
  end

  describe 'Scopes' do
    it '.latest_board returns last board of the game' do
      game = FactoryGirl::create(:game)
      board = FactoryGirl::create(:board, current_player: 1, game_id: game.id)
      expect(Board.latest_board).to eq(board)
    end
  end
end
