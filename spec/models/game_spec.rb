require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl::build(:game)).to be_valid
  end

  let(:game) { FactoryGirl::build(:game) }

  describe 'Active Model Validation' do
    it { expect(game).to validate_presence_of(:player_1_name) }
    it { expect(game).to validate_presence_of(:player_2_name) }
  end

  describe 'ActiveRecord Associations' do
    it { expect(game).to have_many(:boards) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(game).to respond_to(:player_1_score) }
      it { expect(game).to respond_to(:player_2_score) }
      it { expect(game).to respond_to(:draw_score) }
    end

    context 'executes methods correctly' do
      context 'Game Score' do
        it 'should get the player one score' do
          expect(game.player_1_score).to eq(0)
        end

        it 'should get the second player score' do
          expect(game.player_2_score).to eq(0)
        end

        it 'should get the game draw score' do
          expect(game.draw_score).to eq(0)
        end
      end
    end
  end
end
