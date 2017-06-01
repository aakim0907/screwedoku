require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_position
    pos = nil
    until pos && valid_move?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = split_position(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        pos = nil
      end
    end
    pos
  end

  def get_guess
    val = nil
    until val && valid_val?(val)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      val = str_to_int(gets.chomp)
    end
    val
  end

  def split_position(string)
    string.split(",").map { |char| Integer(char) }
  end

  def str_to_int(string)
    Integer(string)
  end

  def play_turn
    make_guess(get_position, get_guess)
    @board.render
  end

  def make_guess(pos, val)
    board[pos] = val
  end

  def play
    @board.render
    play_turn until won?
    puts "Congratulations, you win!"
  end

  def won?
    board.terminate?
  end

  def valid_move?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def valid_val?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.play
