class Board
  def initialize(board = create_board)
    @board = board
  end
  attr_reader :board

  # prints 7 arrays that are an Array with 6 nil, 7 Array represent column, with 6 arrays representing the rows
  def create_board
    Array.new(7, Array.new(6))
  end

  def draw_board
    board_to_print = "_____________________\n"

    row = 0
    board[0].length.times do
      board.map do |column|
        board_to_print += column[row].nil? ? "|◯|" : "|#{column[row]}|"
      end
      board_to_print += "\n"
      row += 1
    end
    board_to_print += "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\n"
    board_to_print += " 1  2  3  4  5  6  7 "

    print board_to_print
  end

  def legal_move?(column)
    return true if @board[column].first.nil?

    false
  end

  def place_token(column, marker)
    result = []
    board[column].each_with_index { |row, index| result << index if row.nil? }
    board[column][result.last] = marker
  end

  def winner?
    false
  end
end
