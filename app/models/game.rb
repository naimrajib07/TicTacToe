# The <tt>Game</tt> class is used when you
# want to play TicTacToe.
class Game < ActiveRecord::Base
  has_many :boards, dependent: :destroy

  validates_presence_of :player_1_name, :player_2_name

  def player_1_score
    boards.player_1_won_count
  end

  def player_2_score
    boards.player_2_won_count
  end

  def draw_score
    boards.drawn_count
  end
end
