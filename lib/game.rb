# frozen_string_literal: true

require_relative('player')

# Game Class
class Game
  attr_accessor :players, :board, :turn

  def initialize
    @players = []
    @board = nil
    @turn = 0
  end

  def register_player(name = "Player_#{rand(1000..2000)}", mark = '⛭')
    @players.push(Player.new(name, mark))
  end

  def game_setup

  end

  def game_start

  end

  def game_over?

  end

  def display_winner
    puts "#{@players[@turn].name} is the winner!"
  end

  def display_tied

  end
end
