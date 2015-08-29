require 'byebug'
require './tile'
require 'colorize'

class Board

  def initialize(grid_size = 9)
    @grid_size = grid_size
    @grid = make_grid(grid_size)
    @num_of_bombs = grid_size ** 2 * rand(12..15) / 100
    @num_of_flags = 0
    populate_grid
    # pop_bomb_count
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def won?
    grid.each do |row|
      row.each do |tile|
        next if tile.value == "B"
        return false unless tile.is_revealed?
      end
    end
    true
  end

  def flag(cor)
    self[cor].flagged? ? @num_of_flags -= 1 : @num_of_flags += 1
    self[cor].flag
  end

  def render
    grid_width = 4 * grid_size + 3

    print "Bombs: #{num_of_bombs}".ljust(grid_width / 2)
    print "Flags: #{num_of_flags}".rjust(grid_width / 2)

    print "\n\n  |"

    (0...grid_size).to_a.each { |n| print " #{n} |" }
    print "\n"
    puts "-" * grid_width
    grid.each_with_index do |row, i|
      print "#{i} |"
      row.each do |tile|
        content = '*'

        if tile.is_revealed?
          content = tile.value.to_s
        else
          content = 'f' if tile.flagged?
        end

        content = colorize_content(content)

        print "#{content}|"
      end
      print "\n"
      puts "-" * grid_width
    end

    true
  end

  def colorize_content(content)
    case content
    when '0'
      '   '
    when 'B'
      ' B '.colorize(:red)
    when 'f'
      ' f '.colorize(:yellow)
    when '*'
      "\e[47m   \e[0m"
    else
      " #{content} ".colorize(:cyan)
    end
  end

  def adj_pos(pos)
    x, y = pos
    arr = []

    (-1..1).to_a.each do |i|
      (-1..1).to_a.each do |j|
        new_pos = [x + i, y + j]
        arr << new_pos unless within_grid?(new_pos) || pos == new_pos
      end
    end
    arr
  end

  private
  attr_reader :grid_size, :grid, :num_of_bombs, :num_of_flags

  def populate_grid
    place_bombs
    grid.each_with_index do |row, i|
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
    pos_taken = []
    until pos_taken.size == num_of_bombs
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

  def within_grid?(pos)
    pos.any? { |cor| cor < 0 || cor > grid_size - 1 }
  end

  def make_grid(grid_size)
    Array.new(grid_size) { Array.new(grid_size) }
  end

  def inspect
    true
  end

end
