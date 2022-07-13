require 'pry-byebug'
board2 = [[nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]]

board = [['🔴', nil, nil,nil, nil, nil], [nil, '🔴', nil, nil, nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]]

board3 = [[nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, nil, nil, '🔴']]

board5 = [[nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, nil, nil, '🔴']]

marker1 = '🔴'
marker2 = '🟡'
row = 0
diagonal_array = []
result = []
dia_row = 0

board3[0].length.times do
  board3.map do |column|
    diagonal_array << column[dia_row]
    dia_row += 1
    break if dia_row >= 6
  end
  i = 0
  3.times do
    break if i + 3 > diagonal_array.length

    result << diagonal_array if diagonal_array[i..i + 3].all? { |m| m == marker1 || m == marker2 }
    i += 1
  end
  row += 1
  dia_row = row
  diagonal_array = []
end
print result

# then for column index 6
row = 0
dia_row = 0
column = 0
diagonal_array = []
result = []


3.times do
  column = 3
  4.times do
    diagonal_array << board3[column][dia_row]
    column += 1
    dia_row += 1
  end
  result << diagonal_array if diagonal_array.all? { |m| m == marker1 || m == marker2 }
  row += 1
  dia_row = row
  diagonal_array = []
end

print result

