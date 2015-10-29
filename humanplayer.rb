class HumanPlayer < Player 

  def get_move
    move_made = false
    selected = false
    start_space = []

    until move_made
      temp_move = @game.display.get_input

      # puts "trying #{temp_move.to_s}"
      # sleep(1)
      if temp_move.is_a?(Array)
        state = temp_move[2]
        if state == "s"
          selected = true
          start_space = [temp_move[0], temp_move[1]]
          #selected_piece = @game.board.grid[temp_move[0]][temp_move[1]]
          #Change color of selected square
          @game.display.selected = start_space
          system("clear")
          @game.display.render
        elsif state == "f"
          finish_space = [temp_move[0], temp_move[1]]
          move_made = true

        end
      else
        system("clear")
        @game.display.render
      end
    end
    # puts "Start is #{start_space}"
    # puts "Finish is #{finish_space}"
    [start_space, finish_space]
  end

  def piece_at?(pos)
    @game.board.grid[pos[0]][pos[1]].color == self.color
  end

end
