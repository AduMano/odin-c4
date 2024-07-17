# frozen_string_literal: true

# Vertex Class
class Vertex
  attr_accessor :row, :column, :slot, :neighbors

  def initialize
    @row = nil
    @column = nil
    @slot = nil
    @neighbors = {
      left: nil, top_left: nil,
      top: nil, top_right: nil,

      right: nil, bottom_right: nil,
      bottom: nil, bottom_left: nil
    }
  end

  def setup_neighbors(row, column, board) # rubocop:disable Metrics/AbcSize
    @neighbors[:left] = board[row][column - 1] if column - 1 >= 0 # left
    @neighbors[:top_left] = board[row - 1][column - 1] if column - 1 >= 0 && row - 1 >= 0 # Top Left
    @neighbors[:top] = board[row - 1][column] if row - 1 >= 0 # Top
    @neighbors[:top_right] = board[row - 1][column + 1] if column + 1 < 7 && row - 1 >= 0 # Top Right

    @neighbors[:right] = board[row][column + 1] if column + 1 < 7 # Right
    @neighbors[:bottom_right] = board[row + 1][column + 1] if column + 1 < 7 && row + 1 < 6 # Bottom Right
    @neighbors[:bottom] = board[row + 1][column] if row + 1 < 6 # Bottom
    @neighbors[:bottom_left] = board[row + 1][column - 1] if column - 1 >= 0 && row + 1 < 6 # Bottom Left
  end
end
