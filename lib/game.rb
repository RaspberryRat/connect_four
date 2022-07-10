require_relative 'board'
require_relative 'player'

class Game
  def initialize(board = Board.new)
    @game_board = board
    @player1 = nil
    @player2 = nil
    @current_player = nil
  end

  attr_accessor :player1, :player2, :current_player
  attr_reader :game_board

  def ask_name
    puts "You are #{@player1.nil? ? 'Player 1' : 'Player 2'}. What is your name?"
    gets.chomp.strip
  end

  def create_players
    @player1 = Player.new(self, ask_name, 1)
    @player2 = Player.new(self, ask_name, 2)
    @current_player = @player1
  end

  def play_game
    create_players if @player1.nil?
    puts 'Enter the column number to place your marker'
    @game_board.draw_board
    choice = player_input(1, 7)
    return play_game unless verify_choice(choice)
    @game_board.place_token(choice, current_player.marker)
  end

  def player_input(min, max)
    loop do
      choice = gets.chomp.to_i
      return choice if verify_input(min, max, choice)

      puts 'Input Error, you must enter a number between 1 and 7'
    end
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end

  def verify_choice(choice)
    return if @game_board.legal_move?(choice)

    puts "Column #{choice} is full, you must choose a different column."
    false
  end
end
