class Level
  include ShadowcastingFieldOfView

  attr_accessor :grid, :play_screen

  def initialize(play_screen)
    play_screen.say("Generating level")
    self.play_screen = play_screen

    self.grid = []
    (0..play_screen.map_screen.getmaxx).each do |x|
      self.grid[x] = []
      (0..play_screen.map_screen.getmaxy).each do |y|
        self.grid[x][y] = Tile.rand
      end
    end
    play_screen.say("Done!")
  end

  def display_map
    play_screen.map_screen.move(0,0)
    (0...play_screen.map_screen.getmaxy).each do |y|
      (0...play_screen.map_screen.getmaxx).each do |x|
        icon = grid[x][y].feature.icon
        play_screen.map_screen.attrset(icon.color)
        play_screen.map_screen.addch(icon.char)
      end
    end
    play_screen.map_screen.refresh
  end

  def blocked?(x,y)
    grid[x][y].blocked?
  end

  def light(x,y)
    grid[x][y].lit = true
  end
end
