require 'pry-byebug'
board = [[nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]]

row = 0
row_array = []
result = []


board[0].length.times do
   board.map do |column|
     row_array << column[row]
   end
   i = 0
   3.times do
    
     result << row_array if row_array[i..i + 3].all?('🔴')
     i += 1
   end
   row += 1
   row_array = []
 end

 print result