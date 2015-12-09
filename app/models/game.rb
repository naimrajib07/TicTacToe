# The <tt>Game</tt> class is used when you
# want to play TicTacToe.
class Game < ActiveRecord::Base
  has_many :boards, dependent: :destroy
end
