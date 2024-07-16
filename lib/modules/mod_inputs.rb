# frozen_string_literal: true

# Input Module
module Inputs
  def inp_player_name
    loop do
      print 'Enter the player\'s name: '
      name = gets.chomp

      return name if name.length > 2

      puts 'Player\'s name must be atleast 2 characters.'
    end
  end

  def inp_player_mark
    marks = ['⛭', '⛒', '⛦', '⛛']

    loop do
      print "\n========================= Marks ==========================\n"
      marks.each_with_index { |mark, index| print "| [#{index + 1}] = '#{mark}' |" }

      print "\n\nEnter the player's mark (1 - #{marks.length}): "
      mark = gets.chomp

      return marks[mark.to_i - 1] if mark.to_i.between?(1, marks.length)

      puts 'Invalid input. please be sure the input is between the given range'
    end
  end
end
