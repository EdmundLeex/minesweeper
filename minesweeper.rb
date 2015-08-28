require 'byebug'
require './board'

class Game

  def initialize
    @board = Board.new
  end

  def play
    until won?
      play_round
    end
  end

  def play_round
    system('clear')
    @board.render

    cor, input = ask_input

    if input == 'r'
      reveal(cor)
    elsif input == 'f'
      @board[cor].flag
    end
  end

  def ask_input
    puts "Please pick a cordinate. (x, y)"
    cor = gets.chomp.split(',').map(&:to_i)
    puts "Please reveal or flag the tile. (r/f)"
    input = gets.chomp
    [cor, input]
  end

  def reveal(pos)
    tile_val = @board[pos].reveal
    game_over if tile_val == 'B'
  end

  def game_over
    puts "BOMB!!!!!!**********!!!!!!!"
    Kernel.abort("You're done!!!")
  end

  def won?
    @board.won?
  end

  def inspect
    true
  end
end
