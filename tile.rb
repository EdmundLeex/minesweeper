class Tile
  attr_accessor :value

  def initialize(val = 0)
    @value = val
    @revealed = true
    @flag = false
  end

  def reveal
    @revealed = true
    value
  end

  def is_revealed?
    @revealed
  end

  def flag
    @flag = flagged? ? false : true
  end

  def flagged?
    @flag
  end
end
