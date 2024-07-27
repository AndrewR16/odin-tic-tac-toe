require_relative 'lib/input'
require_relative 'lib/game'

class Main # rubocop:disable Style/Documentation
  include Input

  def self.run_tic_tac_toe
    puts '--- Tic Tac Toe ---'
    return unless Input.confirmation?('Start a new game? [y/n]: ')

    new_game = Game.new
    new_game.new_turn
  end
end

Main.run_tic_tac_toe
