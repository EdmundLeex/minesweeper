
class Board
  attr_reader :pos_taken

  def initialize
    @grid = make_grid
    @pos_taken = []
  end

  def populate
    @grid.each do |row|
      row.each do |cell|
        if cell.empty?
          cell = Tile.new
      end
    end
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
    arr = []

    (-1..1).to_a.each do |i|
      (-1..1).to_a.each do |j|
        new_pos = [x + i, y + j]
        unless new_pos.any? { |cor| cor < 0 || cor > size } || pos == new_pos
          arr << [new_x, new_y]
        end
      end
    end
    arr
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
    Array.new(size) { Array.new(size) }
  end

  def win?

  end

  private

  attr_reader :size

end
