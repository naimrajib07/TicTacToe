# The <tt>Game</tt> class is used when you
# want to play TicTacToe.
class Game < ActiveRecord::Base
  has_many :boards, dependent: :destroy

  validates_presence_of :player_1_name, :player_2_name

  # @return {INTEGER} no of game won by player one
  def player_1_score
    boards.player_1_won_count
  end

  # @return {INTEGER} no of game won by player two
  def player_2_score
    boards.player_2_won_count
  end

  # @return {INTEGER} no of game drawn between player one and two
  def draw_score
    boards.drawn_count
  end
end
