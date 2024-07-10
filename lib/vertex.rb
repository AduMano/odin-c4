# frozen_string_literal: true

# Vertex Class
class Vertex
  attr_accessor :row, :column, :slot, :neighbors

  def initialize
    @row = nil
    @column = nil
    @slot = nil
    @neighbors = []
  end

  def setup_neighbors(row, column, board) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    @neighbors.push(board[row][column - 1]) if column - 1 >= 0 # left
    @neighbors.push(board[row - 1][column - 1]) if column - 1 >= 0 && row - 1 >= 0 # Top Left
    @neighbors.push(board[row - 1][column]) if row - 1 >= 0 # Top
    @neighbors.push(board[row - 1][column + 1]) if column + 1 < 7 && row - 1 >= 0 # Top Right

    @neighbors.push(board[row][column + 1]) if column + 1 < 7 # Right
    @neighbors.push(board[row + 1][column + 1]) if column + 1 < 7 && row + 1 < 6 # Bottom Right
    @neighbors.push(board[row + 1][column]) if row + 1 < 6 # Bottom
    @neighbors.push(board[row + 1][column - 1]) if column - 1 >= 0 && row + 1 < 6 # Bottom Left
  end
end
