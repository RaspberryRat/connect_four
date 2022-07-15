# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class Game
  def initialize(board = Board.new(self), current_player = nil)
    @game_board = board
    @current_player = current_player
    @player1 = nil
    @player2 = nil
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
    loop do
      create_players if @current_player.nil?
      puts "\n\nIt is #{current_player.name}'s turn\n"
      puts "Enter the column number to place your marker>>\n"
      @game_board.draw_board
      choice = player_input(1, 7)
      choice = choice.to_i - 1

      return play_game unless verify_choice(choice)

      @game_board.place_token(choice, current_player.marker)
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
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
    return true if @game_board.legal_move?(choice)

    puts "Column #{choice} is full, you must choose a different column."
    false
  end

  def game_over
    puts "\n\n#{current_player.name} is the winner!\n"
    new_game_ask
  end

  def new_game_ask
    puts 'Would you like to play again? (yes/no)'
    return Game.new.play_game if yes_no_input

    exit
  end

  private

  def yes_no_input
    input = ''
    loop do
      input = gets.chomp.strip.downcase
      return true if input == 'yes'

      return false if input == 'no'

      puts "\n\nYou must enter 'yes' or 'no'\n"
    end
  end
end

#TODO Placing token isn't working or draw_board isn't taking updated drawing