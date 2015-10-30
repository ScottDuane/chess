require_relative 'player.rb'
require_relative 'Display.rb'
require_relative 'Board.rb'
require_relative 'humanplayer.rb'
require_relative 'computerplayer.rb'


class Game
  attr_reader :display, :board, :current_player

  def initialize(board)
    @board = board
    @display = Display.new(board, self)
    @current_player = HumanPlayer.new(:white, self)
    @other_player = ComputerPlayer.new(:black, self)
  end

  def play
    until self.game_over?
      @display.render

      move = @current_player.get_move
      puts "Move is: #{move}"
      # debugger
      successful_move = @board.make_move(move[0], move[1], @current_player.color)

      if successful_move
        switch_players
      else
        puts "Invalid move.  Try again."
        sleep(2)
      end
      @display.selected = nil
      @display.cursor_pos = [0,0]
      @display.render
      #try_to_save

    end

    puts "GAME OVER. #{@other_player.color} player WON!!"
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def game_over?
    #puts "In game over method"
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end

  def try_to_save
      puts "Name your file:"
      file_name = gets.chomp
      File.write("./#{file_name}.yaml", self.to_yaml)
      Kernel.abort
  end
end

if(__FILE__ == $PROGRAM_NAME)
  if ARGV.empty?
    #Welcome message
    game_board = Board.new()
    game = Game.new(game_board)
      #dis = Display.new(game_board, game)
    game.play
  else
    load_file_name = ARGV.shift
    YAML.load_file(load_file_name).play
  end
end
