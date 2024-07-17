# frozen_string_literal: true

require_relative('vertex')
require_relative('piece')

# Board Class
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) { Vertex.new } }
  end

  def build_board
    @board.each_with_index do |row, i|
      row.each_with_index do |column, j|
        # Setup Row and Columns
        column.row = i
        column.column = j

        # Setup Neighbors Boundaries
        column.setup_neighbors(i, j, @board)
      end
    end
  end

  def place_piece(player, column)
    return false unless @board[0][column - 1].slot.nil?

    piece = Piece.new(player.mark, player.color, player)
    @board[0][column - 1].slot = piece

    fall_down_piece(@board[0][column - 1])
  end

  def fall_down_piece(current, depth = 0)
    loop do
      break if current.neighbors[:bottom].nil?
      break unless current.neighbors[:bottom].slot.nil?

      # Get the Piece
      piece = current.slot

      # Set the current slot to nil
      current.slot = nil

      # Set the current to bottom slot
      current = current.neighbors[:bottom]

      # Set the current slot to piece
      current.slot = piece

      depth += 1
    end

    depth
  end

  def pattern_found?(row, column)
    board = @board[row][column]

    return true if check_pattern_dir(:top, board)
    return true if check_pattern_dir(:top_right, board)
    return true if check_pattern_dir(:right, board)
    return true if check_pattern_dir(:bottom_right, board)

    return true if check_pattern_dir(:bottom, board)
    return true if check_pattern_dir(:bottom_left, board)
    return true if check_pattern_dir(:left, board)
    return true if check_pattern_dir(:top_left, board)

    false
  end

  def render_board
  end

  private

  def check_pattern_dir(direction, current, counter = 1)
    return true if counter.eql?(4)
    return false if current.neighbors[direction].nil?
    return false if current.neighbors[direction].slot.nil?

    check_pattern_dir(direction, current.neighbors[direction], counter + 1)
  end
end
