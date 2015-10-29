require_relative 'Piece.rb'
require_relative 'slidable.rb'
class Rook < Piece
  include Slidable
  def display
    if @color == :white
      "\u2656"
    else
      "\u265C"
    end
  end

end
