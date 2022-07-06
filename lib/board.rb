
class Board
  def initialize
    @board = nil
  end
  attr_reader :board

  def create_board
    {
      row_1: Array.new(7),
      row_2: Array.new(7),
      row_3: Array.new(7),
      row_4: Array.new(7),
      row_5: Array.new(7),
      row_6: Array.new(7),
    }
  end
end