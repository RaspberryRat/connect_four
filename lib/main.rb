# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'game'

puts "Welcome to Connect 4!\nThe object is to get 4 of your markers in a row before your opponent!\nThis game supports two human players.\nnGood luck\n\n"

Game.new.play_game
