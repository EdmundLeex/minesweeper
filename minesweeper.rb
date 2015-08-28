require 'byebug'
require './board'
# require 'YAML'

class Game
  def self.load(file)
    YAML::load_file(file)
  end

  def initialize
    @board = Board.new
  end

  def play
    until won?
      play_round
    end

    puts "Won!!!"
  end

  def play_round
    system('clear')
    @board.render

    cor, input = ask_input

    save if cor == 'save' || input == 'save'

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
    # debugger
    queue = [pos]
    visited_pos = []

    until queue.empty?
      cor = queue.shift
      tile = @board[cor]

      if tile.value == 0
        # debugger
        reveal_one_tile(cor)
        arr = @board.adj_pos(cor)
        arr.each do |pos|
          unless visited_pos.include?(pos)
            queue << pos
            visited_pos << pos
          end
        end
      elsif tile.value != 'B' && tile.value > 0
        reveal_one_tile(cor)
      else
        reveal_one_tile(cor)
      end
    end
  end

  def reveal_one_tile(pos)
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

  def save
    puts "What's your filename?"
    filename = gets.chomp
    File.write(filename, self.to_yaml)
    Kernel.abort("Game saved!")
  end

  def inspect
    true
  end

end
