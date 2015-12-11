# Every Board has game and create new board after each game
# has been finish.
class BoardsController < ApplicationController
  before_action :load_game_board

  def show
  end

  # POST Move to next Grid of the board for current court

  def next_move
    move_message = @board.move(params[:row], params[:col])

    respond_to do |format|
      if move_message == :next_move
        @board.save!
        format.json { render json: {
            status: @board.status, current_player: @board.current_player,
            move_message: move_message, code: 200
        }
        }
      else
        format.json { render json: {
            status: @board.status, current_player: @board.current_player,
            move_message: move_message, code: 200
        }
        }
      end
    end
  end

  private

  def load_game_board
    @game = Game.find(params[:game_id])
    @board = Board.find(params[:id])
  end
end
