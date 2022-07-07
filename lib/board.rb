
class Board
  def initialize
    @board = create_board
  end
  attr_reader :board

  def create_board
    Array.new(7, Array.new(6))
  end

  # def draw_board
  #   board.map do |key, value|
  #     value.map do |v|
  #       print "|◯|" if v.nil?
  #       print "|#{v}|" unless v.nil?
  #     end
  #     print "\n"
  #   end
  # end
end