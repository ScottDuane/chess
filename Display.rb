require_relative 'Board.rb'
require 'colorize'
require 'io/console'
require_relative 'cursorable'
#require_relative 'game.rb'

class Display
#  include Cursorable

  KEYMAP = {
    " " => :space,
  #  "h" => :left,
  #  "j" => :down,
  #  "k" => :up,
  #  "l" => :right,
    "a" => :left,
    "z" => :down,
    "w" => :up,
    "s" => :right,
  #  "\t" => :tab,
    "\r" => :return,
  #  "\n" => :newline,
  #  "\e" => :escape,
  #  "\e[A" => :up,
  #  "\e[B" => :down,
  #  "\e[C" => :right,
  #  "\e[D" => :left,
  #  "\177" => :backspace,
  #  "\004" => :delete,
    "\u0003" => :ctrl_c,
    "\u0013" => :ctrl_s
  }

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [-1, 0],
    down: [1, 0]
  }
  attr_accessor :cursor_pos, :selected, :game

  def initialize(board, game)
    @game = game
    @board = board
    @cursor_pos = [0,0]
    @selected = nil
    @possibles = []
  end

  def render
    system("clear")
    print_black_captures

    @board.grid.each_with_index do |row, idx|
      render_blank_line(row, idx)
      render_row(row, idx)
      render_blank_line(row, idx)
    end

    print_letters
    print_white_captures
    puts "Current player is #{@game.current_player.color}"
  end

  def render_blank_line(row, idx)
    print "   "
    row.each_with_index do |el, idy|
      background = nil
      (idx + idy).even? ? background = :black : background = :white
      background = :yellow if @cursor_pos == [idx, idy]
      background = :green if @selected == [idx, idy]
      print "        ".colorize( :background => background)
    end
    puts ""
  end

  def render_row(row, idx)
    print " #{idx} "
    row.each_with_index do |el, idy|
      background = nil
      (idx + idy).even? ? background = :black : background = :white
      background = :magenta if @possibles.include?([idx,idy])
      background = :yellow if @cursor_pos == [idx, idy]
      background = :green if @selected == [idx, idy]
      print "   #{el.display}    ".colorize( :color => :blue, :background => background)
    end
    puts ""
  end

  def print_black_captures
    puts "Black Captures:"
    @board.black_captures.each do |el|
      print " #{el.display}  "
    end
    puts ""
  end

  def print_white_captures
    puts "White Captures:"
    @board.white_captures.each do |el|
      print " #{el.display}  "
    end
    puts ""
  end

  def print_letters
    print "   "
    letter = ("A".."H").to_a
    letter.each {|el| print "   #{el}    " }
    puts ""
  end



  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def handle_key(key)
    case key
    when :ctrl_s
      self.game.try_to_save
    when :ctrl_c
      exit 0
    when :space
      info = @cursor_pos
      info << "s"
      info
    when :return
      info = @cursor_pos
      info << "f"
      info
    when :left, :right, :up, :down
      update_pos(MOVES[key])
      nil
    else
      puts key
    end
  end

  def update_pos(diff)
    new_pos = [@cursor_pos[0] + diff[0], @cursor_pos[1] + diff[1]]
    #@board.grid[@cursor_pos[0]][@cursor_pos[1]].colorize(:background => :blue)
    @cursor_pos = new_pos if @board.in_bounds?(new_pos)
    #@board.grid[@cursor_pos[0]][@cursor_pos[1]].colorize(:background => :yellow)

  end
  #
  # def get_move_from_user
  #   key = KEYMAP[read_char]
  #   handle_key(key)
  # end
end
