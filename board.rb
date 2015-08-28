require 'byebug'
require './tile'
class Board
  attr_reader :pos_taken, :grid

  def initialize(grid_size = 9)
    @grid_size = grid_size
    @grid = make_grid(grid_size)
    @pos_taken = []
    populate_grid
    # pop_bomb_count
  end

  def populate_grid
    place_bombs
    @grid.each_with_index do |row, i|
      row.each_index do |j|
        pos = [i, j]
        if self[pos].nil?
          self[pos] = tile = Tile.new
          bomb_count(pos)
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

  def bomb_count(pos)
    tile = self[pos]
    adj_pos(pos).each do |cor|
      # debugger
      if !self[cor].nil? && self[cor].value == "B"
        tile.value += 1
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
          arr << new_pos
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

  def won?
    @grid.each do |row|
      row.each do |tile|
        next if tile.value == "B"
        return false unless tile.is_revealed?
      end
    end
    true
  end

  def render
    puts "-" * (4 * grid_size + 1)
    @grid.each do |row|
      print '|'
      row.each do |tile|
        content = '*'
        if tile.is_revealed?
          content = tile.value.to_s
          content = ' ' if content == '0'
        else
          content = 'f' if tile.flagged?
        end
        print " #{content} |"
      end
      print "\n"
      puts "-" * (4 * grid_size + 1)
    end

    true
  end

  private

  attr_reader :grid_size

  def inspect
    true
  end

end
