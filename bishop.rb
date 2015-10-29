require_relative 'Piece.rb'
require_relative 'slidable.rb'
class Bishop < Piece
  include Slidable
  def display
    if @color == :white
      "\u2657"
    else
      "\u265D"
    end
  end
end
