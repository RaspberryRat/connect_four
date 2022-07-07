def create_board
  Array.new(7, Array.new(6))
end

board = create_board

board[0][1] = 'X'
board[6][5] = 'P'
i = 0
j = 0
while j < board.length
  board.map do |column|
    if column[i].nil?
      print "|o|"
    else
      print "|#{column[i]}|"
    end
    if column.length - 1 == i
      i = 0
      j += 1
      print "\n"
    else
      i += 1
    end
  end
end
