require_relative 'board'
require_relative 'player'

class Game
  def initialize(board = Board.new)
    @game_board = board
    @player1 = nil
    @player2 = nil
  end

  attr_accessor :player1, :player2

  def ask_name
    puts "You are #{@player1.nil? ? 'Player 1' : 'Player 2'}. What is your name?"
    gets.chomp.strip
  end

  def create_players
    @player1 = Player.new(self, ask_name, 1)
    @player2 = Player.new(self, ask_name, 2)
  end
  
end
Game.new