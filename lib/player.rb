# frozen_string_literal: true

# Player Class
class Player
  attr_accessor :name, :mark

  def initialize(name = "Player_#{rand(1000..2000)}", mark = '⛭')
    @name = name
    @mark = mark
  end
end
