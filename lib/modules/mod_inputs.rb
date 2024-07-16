# frozen_string_literal: true

# Input Module
module Inputs
  def inp_player_name
    print 'Enter the player\'s name: '
    name = gets.chomp
  end
end
