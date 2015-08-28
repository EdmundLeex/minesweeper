require 'byebug'
require './board'

class Game

  def initialize
    @board = Board.new
  end

  def input
    puts "Please pick a cordinate. (x, y)"
    cor = gets.chomp.split(',').map(&:to_i)
    puts "Please reveal or flag the tile. (r/f)"
    input = gets.chomp
    [cor, input]
  end

  def reveal(pos)
    tile_val = @board[pos].reveal

    game_over if tile_val == 'B'
    system('clear')
    @board.render
  end

  def flag_bomb

  end

  def game_over
    puts "BOMB!!!!!!**********!!!!!!!"
    Kernal.abort("You're done!!!")
  end

  def won?

  end

  def inspect
    true
  end
end
