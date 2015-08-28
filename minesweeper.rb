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
  attr_reader :pos_taken

  def initialize
    @grid = Board.populate
    @pos_taken = []
  end

  def populate

  end

  def place_bomb
  #randomly puts bomb into grid
    until pos_taken.size == 10
      pos = [rand(size), rand(size)]

      unless pos_taken.include?(pos)
        pos_taken << pos
        self[pos] = Tile.new("B")
      end
    end
  end

  def adj_pos(pos)
    x, y = pos
    arr = [
      [x - 1, y + 1],
      [x, y + 1],
      [x + 1, y + 1],
      [x + 1, y],
      [x + 1, y - 1],
      [x, y - 1],
      [x - 1, y - 1],
      [x - 1, y]
    ]

    arr.reject do |pos|
      x, y = pos
      x < 0 || y < 0 || x > size - 1 || y > size - 1
    end

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def make_grid(size = 9)
    @grid = Array.new(size) { Array.new(size) }
  end

  def win?

  end

  private

  attr_reader :size

end

class Tile
  attr_reader :value

  def initialize(val)
    @value = val
  end

  def reveal

  end

  def value

  end
end
