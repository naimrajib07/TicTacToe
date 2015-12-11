require 'rails_helper'

RSpec.describe Board, type: :model do
  def make_initial_court
    Array.new(3) { Array.new(3) { 0 } }
  end

  def make_initial_court_with_invalid_value
    Array.new(3) { Array.new(3) { 5 } }
  end

  it 'has a valid factory' do
    expect(FactoryGirl::build(:board)).to be_valid
  end

  let(:board) { FactoryGirl::build(:board, court: make_initial_court) }

  describe 'Active Model Validation' do
    it { expect(board).to validate_presence_of(:game_id) }
    it { expect(board).to validate_presence_of(:current_player) }
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

    it '.player_1_won_count returns all  board of the game that won by player 1' do
      game = FactoryGirl::create(:game)
      board = FactoryGirl::create(:board, current_player: 1, game_id: game.id, status: 3)
      expect(Board.player_1_won_count).to eq(1)
    end

    it '.player_2_won_count returns all  board of the game that won by player 2' do
      game = FactoryGirl::create(:game)
      board = FactoryGirl::create(:board, current_player: 1, game_id: game.id, status: 4)
      expect(Board.player_2_won_count).to eq(1)
    end

    it '.drawn_count returns drawn board of the game' do
      game = FactoryGirl::create(:game)
      board = FactoryGirl::create(:board, current_player: 1, game_id: game.id, status: 2)
      expect(Board.drawn_count).to eq(1)
    end
  end

  context 'callbacks' do
    it { expect(board).to callback(:court_initialization).after(:initialize) }
    it { expect(board).to callback(:set_player).after(:initialize) }
    it { expect(board).to callback(:switch_level_player).after(:initialize) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(board).to respond_to(:move) }
      it { expect(board).to respond_to(:turn_complete?) }
    end

    context 'executes methods correctly' do
      context '#move' do
        it 'move to next turn of the grid' do
          expect(board.move(0, 0)).to eq(:next_move)
        end

        it 'move will fail of the grid' do
          board.court[0][0] = 5
          board.save!
          expect(board.move(0, 0)).to eq(:illegal_move)
        end
      end
    end
  end
end
