require "pry-byebug"
board = [[nil, 1, nil], [3, 4, 5], [6, nil, nil], [9, 0, 8]]

row = 0
to_print = ''
board[0].length.times do
  board.map do |column|
    if column[row].nil?
      to_print += "|o|"
    else
      to_print += "|#{column[row]}|"
    end
  end
  to_print += "\n"
  row += 1
end

print to_print