require_relative 'Piece.rb'
require_relative 'steppable.rb'

class King < Piece
  include Steppable
  def initialize(pos, color, board)
    super
    @possible_moves = [
      [-1,1],
      [-1,-1],
      [1,-1],
      [1,1],
      [-1,0],
      [0,-1],
      [1,0],
      [0,1]
    ]
  end


  def display
    if @color == :white
      "\u2654"
    else
      "\u265A"
    end
  end


end
