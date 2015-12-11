# Board specific view helper method
module BoardsHelper
  # return board player name
  def current_player_name(board)
    board.current_player == 1 ? board.game.player_1_name : board.game.player_2_name
  end
end
