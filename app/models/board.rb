# The <tt>Board</tt> class is used when you
# want to play TicTacToe for a game with multiple round.
class Board < ActiveRecord::Base
  belongs_to :game

  scope :latest_board, -> { order('created_at DESC').last }
end
