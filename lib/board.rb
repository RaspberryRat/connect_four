require 'pry-byebug'
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
    return game_over if winner?
  end

  def winner?
    return true if four_in_a_row?

    false
  end

  def four_in_a_row?
    marker1 = '🔴'
    marker2 = '🟡'
    result = []

    # to find four markers in same column
    board.each do |column|
      i = 0
      3.times do
        result << column if column[i..i + 3].all? { |m| m == marker1 || m == marker2 }
        i += 1
      end
    end

    return true unless result.empty?

    # to find four markers in same row
    row = 0
    row_array = []
    result = []
    i = 0
    board[0].length.times do
      board.map do |column|
        row_array << column[row]
      end
      i = 0
      3.times do
        result << row_array if row_array[i..i + 3].all? { |m| m == marker1 || m == marker2 }
        i += 1
      end
      row += 1
      row_array = []
    end

    # finds four markers on a descending diagonal, except in column index 6
    row = 0
    diagonal_array = []
    dia_row = 0
    board[0].length.times do
      board.map do |column|
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

    # finds four markers on descending diagonal if end in column index 6
    row = 0
    dia_row = 0
    diagonal_array = []
    3.times do
      column = 3
      4.times do
        diagonal_array << board[column][dia_row]
        column += 1
        dia_row += 1
      end
      result << diagonal_array if diagonal_array.all? { |m| m == marker1 || m == marker2 }
      row += 1
      dia_row = row
      diagonal_array = []
    end

    return true unless result.empty?

    false
  end

  def game_over
    true
  end
  
end
