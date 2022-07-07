require "pry-byebug"
board = [[nil, 1, nil], [3, 4, 5], [6, nil, nil]]

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
  if i == 2
    break
  else
    i += 1
    print "\n"
  end
end
