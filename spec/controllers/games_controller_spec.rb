require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  def valid_attributes
    {player_1_name: 'tes1', player_2_name: 'tes2'}
  end

  def invalid_attributes
    {player_1_name: '', player_2_name: ''}
  end

  describe 'GET new' do
    it 'assigns a new Game as @game' do
      get :new, {}
      assigns(:game).should be_a_new(Game)
    end
  end

  describe 'POST create' do
    context 'With Valid Params' do
      it 'successfully create new game' do
        expect {
          post :create, {game: valid_attributes}
        }.to change(Game, :count).by(1)
      end

      it 'successfully create new game should persist' do
        post :create, {game: valid_attributes}
        assigns(:game).should be_a(Game)
        assigns(:game).should be_persisted
      end
    end

    context 'With Invalid Params' do
      it 'assigns a newly created but unsaved game as @game' do
        Game.any_instance.stub(:save).and_return(false)
        post :create, {game: invalid_attributes}
        assigns(:game).should be_a_new(Game)
      end

      it 're-renders the \'new\' template' do
        Game.any_instance.stub(:save).and_return(false)
        post :create, {game: invalid_attributes}
        response.should render_template(:new)
      end
    end
  end
end
