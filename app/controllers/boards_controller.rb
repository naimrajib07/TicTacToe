# Every Board has game and create new board after each game
# has been finish.
class BoardsController < ApplicationController
  before_action :load_game_board, only: :show

  def show
  end

  private

  def load_game_board
    @game = Game.find(params[:game_id])
    @board = Board.find(params[:id])
  end
end
