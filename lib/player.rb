# frozen_string_literal: true

# Player Class
class Player
  attr_accessor :color, :name, :mark

  def initialize(color, name = "Player_#{rand(1000..2000)}", mark = '⛭')
    @name = name
    @mark = mark
    @color = color
  end
end
