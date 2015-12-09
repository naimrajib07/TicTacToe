# The <tt>Game</tt> class is used when you
# want to play TicTacToe.
class Game < ActiveRecord::Base
  has_many :boards, dependent: :destroy

  validates_presence_of :player_1_name, :player_2_name
end
