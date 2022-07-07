
class Board
  def initialize
    @board = create_board
  end
  attr_reader :board

  # prints 7 arrays that are an Array with 6 nil, 7 Array represent column, with 6 arrays representing the rows
  def create_board
    Array.new(7, Array.new(6))
  end

  def draw_board
    board_to_print = ''
    row = 0
    board[0].length.times do
      board.map do |column|
        if column[row].nil?
          board_to_print += "|◯|"
        else
          board_to_print += "|#{column[row]}|"
        end
      end
      board_to_print += "\n"
      row += 1
    end
    print board_to_print
  end

  def legal_move?(column)
    return true if @board[column].first.nil?
    false
  end
end
