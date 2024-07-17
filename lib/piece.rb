# frozen_string_literal: true

# Class Piece
class Piece
  attr_reader :mark, :color, :owner

  def initialize(mark, color, owner)
    @mark = mark
    @color = color
    @owner = owner
  end
end
