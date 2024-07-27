require_relative 'input'

# Represents a game of tic tac toe
class Game
  attr_accessor :game_board, :round_index, :current_player

  def initialize
    @game_board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    @round_index = 0
    @current_player = :X
  end

  def new_turn
    print_divider
    self.round_index += 1
    puts "Round #{round_index} - Current Player: #{current_player}"

    get_move
    print_game_board

    check_for_winner
    check_for_tie
    swap_current_player

    new_turn
  end

  private

  def print_divider
    puts "\n/----------------------------/\n\n"
  end

  def get_move # rubocop:disable Naming/AccessorMethodName
    loop do
      print 'Move: '
      move = gets.chomp.upcase.to_sym
      break if move_valid?(move)
    end
  end

  def move_valid?(move) # rubocop:disable Metrics/MethodLength
    allowed_moves = {
      TL: [0, 0],
      TC: [0, 1],
      TR: [0, 2],
      CL: [1, 0],
      CC: [1, 1],
      C: [1, 1],
      CR: [1, 2],
      BL: [2, 0],
      BC: [2, 1],
      BR: [2, 2]
    }

    return false unless allowed_moves.key?(move)
    return false unless game_board[allowed_moves[move][0]][allowed_moves[move][1]] == ' '

    game_board[allowed_moves[move][0]][allowed_moves[move][1]] = current_player
    true
  end

  def print_game_board
    puts
    print_row(0)
    puts '───────────'
    print_row(1)
    puts '───────────'
    print_row(2)
  end

  def print_row(index)
    puts " #{game_board[index][0]} │ #{game_board[index][1]} │ #{game_board[index][2]}"
  end

  def check_for_winner
    return unless scan_rows || scan_columns || scan_diagonals

    print_divider
    puts "Winner: #{current_player}"
    prompt_new_game
  end

  def check_for_tie
    return unless round_index == 9

    print_divider
    puts 'Tie Game'
    prompt_new_game
  end

  def prompt_new_game
    if Input.confirmation?('New round? [y/n]: ')
      new_game = Game.new
      new_game.new_turn
    else
      exit
    end
  end

  def scan_rows
    game_board.each do |row|
      return true if row.all?(current_player)
    end

    false
  end

  def scan_columns
    columns = []
    3.times do |index|
      columns[index] = game_board.map { |row| row[index] }
    end

    columns.each do |column|
      return true if column.all?(current_player)
    end

    false
  end

  def scan_diagonals # rubocop:disable Metrics/AbcSize
    return true if [game_board[0][0], game_board[1][1], game_board[2][2]].all?(current_player)

    [game_board[0][2], game_board[1][1], game_board[2][0]].all?(current_player)
  end

  def swap_current_player
    self.current_player = current_player == :X ? :O : :X
  end
end
