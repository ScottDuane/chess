require_relative 'Piece.rb'
require_relative 'slidable.rb'
require 'byebug'
class Queen < Piece
  # debugger
 include Slidable
  def display
    if @color == :white
      "\u2655"
    else
      "\u265B"
    end
  end
end
