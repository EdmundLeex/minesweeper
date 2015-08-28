class Tile
  attr_accessor :value

  def initialize(val = 0)
    @value = val
    @revealed = false
    @flag = false
  end

  def reveal
    @revealed = true
  end

  def revealed?
    @revealed
  end

  def flag
    @flag = flagged? ? false : true
  end

  def flagged?
    @flag
  end
end
