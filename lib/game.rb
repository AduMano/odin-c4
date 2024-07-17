# frozen_string_literal: true

require_relative('player')
require_relative('board')
require_relative('modules/mod_inputs')

# Game Class
class Game
  include(Inputs)

  attr_accessor :players, :board, :turn

  def initialize
    @players = []
    @board = Board.new
    @turn = 0
  end

  def register_player(name, mark, color)
    @players.push(Player.new(color, name, mark))
  end

  def game_setup
    puts '=========== | CONNECT - 4 | ==========='
    puts 'Welcome! lets register your game names.'

    puts "\nPLAYER 1:"
    register_player(inp_player_name, inp_player_mark, :yellow)

    puts "\nPLAYER 2:"
    register_player(inp_player_name, inp_player_mark, :red)

    @board.build_board

    puts 'Great! Enjoy the game!'
  end

  def game_start
    game_setup

    loop do
      @board.render_board

      puts "#{@players[@turn % 2].name}'s Turn!"
      column = inp_place_mark
      row = @board.place_piece(@players[@turn % 2], column)

      break if game_over?(row, column)

      @turn += 1
    end
  end

  def game_over?(row, column)
    if @board.pattern_found?(row, column - 1)
      @board.render_board
      display_winner
      return true
    elsif @board.board_full?
      @board.render_board
      display_tied
      return true
    end

    false
  end

  def display_winner
    print "\n"
    puts "#{@players[@turn % 2].name} is the winner!"
  end

  def display_tied
    puts 'TIE! No one wins!'
  end
end
