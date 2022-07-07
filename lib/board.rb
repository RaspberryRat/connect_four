
class Board
  def initialize
    @board = create_board
  end
  attr_reader :board

  # prints 7 arrays that are an Array with 6 nil, 7 Array represent column, with 6 arrays representing the rows
  def create_board
    Array.new(7, Array.new(6))
  end

  def draw_board(board)
    i = 0
    j = 0
    while j < board.length
      board.map do |column|
        if column[i].nil?
          print "|o|"
        else
          print "|#{column[i]}|"
        end
      end
      if i == 6
        break
      else
        i += 1
        print "\n"
      end
    end
  end
end