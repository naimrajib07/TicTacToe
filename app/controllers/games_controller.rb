# Game controller create new game and show the current or old
# played game.
class GamesController < ApplicationController
  before_action :find_or_create_empty_game_board, only: :show

  # initiate new game instance
  def new
    @game = Game.new
  end

  # create new game
  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_url(id: @game.id)
    else
      render :new
    end
  end

  # show specific game with their associated board
  def show
    redirect_to game_board_url(id: @board.id, game_id: @game.id)
  end

  private

  # Strong param for white list
  def game_params
    params.require(:game).permit(:player_1_name, :player_2_name)
  end

  # load the game and their latest board. If their is no board,
  # in a case of new level, then create new board.
  def find_or_create_empty_game_board
    @game = Game.find_or_create_by(id: params[:id])
    @board = @game.boards.order('created_at').last
    @board = @game.boards.create if @board.nil? || @board.turn_complete?
  end
end
