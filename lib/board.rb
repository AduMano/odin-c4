# frozen_string_literal: true

require_relative('vertex')

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
        columns.setup_neighbors(i, j, @board)
      end
    end
  end
end
