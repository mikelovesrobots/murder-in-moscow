class Level
  include ShadowcastingFieldOfView

  attr_accessor :grid, :play_screen

  def initialize(play_screen)
    play_screen.say("Generating level")
    self.play_screen = play_screen

    self.grid = []
    (0..255).each do |x|
      self.grid[x] = []
      (0..255).each do |y|
        self.grid[x][y] = Tile.rand
      end
    end
    play_screen.say("Done!")
  end

  def blocked?(x,y)
    grid[x][y].blocked?
  end

  def light(x,y)
    grid[x][y].lit = true
  end
end
