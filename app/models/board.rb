# The <tt>Board</tt> class is used when you
# want to play TicTacToe for a game with one or more round.
class Board < ActiveRecord::Base
  belongs_to :game

  validates_presence_of :game_id, :current_player

  serialize :court

  after_initialize :court_initialization, :set_player,
                   :switch_level_player, if: :new_record?

  # Assume value for board: *0* indicates the board court currently initial state, *1* for Player 1,
  # and *2* for Player 2. From these value, we will calculate the game state.
  # The win condition: sum of one of the row or column or diagonal column should be 3 when then player 1 won,
  # and 12 when the player 2 won.
  #
  # court value for second player must be greater than  3 times of first player court value.

  COURT_VALUE = [0, 1, 4]

  enum status: [:initial, :inprogress, :drawn, :player_1_won, :player_2_won]

  scope :latest_board, -> { order('created_at DESC').last }
  scope :player_1_won_count, -> { where('status=?', Board.statuses[:player_1_won]).count }
  scope :player_2_won_count, -> { where('status=?', Board.statuses[:player_2_won]).count }
  scope :drawn_count, -> { where('status=?', Board.statuses[:drawn]).count }

  def move(row, col)
    row, col = row.to_i, col.to_i
    return :out_of_range if !(0..2).include?(row) && !(0..2).include?(col)
    return :illegal_move if court[row][col] != COURT_VALUE[0]
    return :game_over if turn_complete?

    update_court(row, col)
    update_status
    switch_player
    return :next_move, current_player
  end

  def turn_complete?
    [:drawn, :player_1_won, :player_2_won].include?(check_board)
  end

  private

  def court_initialization
    self.court = Array.new(3) { Array.new(3) { 0 } }
  end

  def set_player
    self.current_player = COURT_VALUE[1]
  end

  def get_player_value
    COURT_VALUE[current_player]
  end

  def switch_player
    self.current_player = current_player == COURT_VALUE[1] ? 2 : 1
  end

  def switch_level_player
    self.current_player = game && game.boards.count.even? ? 1 : 2
  end

  def update_court(row, column)
    self.court[row.to_i][column.to_i] = get_player_value
  end

  def empty_court?
    court.flatten.count(0) == 9
  end

  def wining_court
    grid = []

    (0..2).each do |position|
      grid << court[position] # Row
      grid << court.transpose[position] # Column
    end

    grid << [court[0][0], court[1][1], court[2][2]] # Left Diagonal
    grid << [court[0][2], court[1][1], court[2][0]] # Right Diagonal

    return grid
  end

  def check_board
    return :initial if empty_court?

    wining_court.each do |line|
      return :player_1_won if line.sum == COURT_VALUE[1] * 3
      return :player_2_won if line.sum == COURT_VALUE[2] * 3
    end

    return :inprogress if court.flatten.include?(COURT_VALUE[0])
    return :drawn
  end

  def update_status
    self.status = check_board
  end
end
