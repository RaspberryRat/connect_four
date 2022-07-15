# frozen_string_literal: true

# creates a object for human players and assigns a maker
class Player
  @@player_count = 0
  def initialize(game, name, player)
    @@player_count += 1
    @game = game
    @name = name
    @player = player
    @marker = assign_marker
  end
  attr_reader :game, :name, :marker

  def assign_marker
    return '🔴' if @player == 1

    '🟡'
  end
end
