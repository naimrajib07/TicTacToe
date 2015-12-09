class GamesController < ApplicationController
  before_action :find_or_create_empty_game_board, only: :show

  def new
    @game = Game.new
  end

  def create
  end

  def show
  end

  private

  def find_or_create_empty_game_board
    @game = Game.find_or_create_by(id: params[:id])
    @board = @game.boards.latest_board
    @game.create_boards if @board.nil?
  end
end
