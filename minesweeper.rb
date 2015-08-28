class Game

  def initialize
    @board
  end

  def input(pos, act)

  end

  def reveal

  end

  def flag_bomb

  end
end

class Board

  def self.populate

  end

  def initialize
    @grid = Board.populate
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def make_grid(size = 3)
    @grid = Array.new(size) { Array.new(size) }
  end

  def win?

  end

end

class Tile
  attr_reader :value

  def initialize(val)
    @value = val
  end
end
