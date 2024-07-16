# frozen_string_literal: true

# Player Class
class Player
  attr_accessor :color, :name, :mark

  def initialize(color, name, mark)
    @name = name
    @mark = mark
    @color = color
  end
end
