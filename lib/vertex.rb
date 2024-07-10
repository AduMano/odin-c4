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

  def setup_neighbors(row, column, board)
    
  end
end
