require 'byebug'
require './tile'
class Board
  attr_reader :pos_taken, :grid

  def initialize(grid_size = 9)
    @grid_size = grid_size
    @grid = make_grid(grid_size)
    @pos_taken = []
    place_bombs
    populate
  end

  def populate
    @grid.each do |row|
      row.each do |cell|
        if cell.nil?
          cell = Tile.new
        end
      end
    end
  end

  def place_bombs
  #randomly puts bomb into grid
    until @pos_taken.size == 10
      pos = [rand(grid_size), rand(grid_size)]

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
        unless new_pos.any? { |cor| cor < 0 || cor > grid_size - 1 } || pos == new_pos
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

  def make_grid(grid_size)
    Array.new(grid_size) { Array.new(grid_size) }
  end

  def win?

  end

  private

  attr_reader :grid_size

end
