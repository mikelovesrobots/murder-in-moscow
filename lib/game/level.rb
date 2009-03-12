class Level
  include ShadowcastingFieldOfView

  attr_accessor :grid, :play_screen

  def initialize(play_screen)
    play_screen.say("Generating level")
    self.play_screen = play_screen

    self.grid = []
    (0...play_screen.map_screen.getmaxx).each do |x|
      self.grid[x] = []
      (0...play_screen.map_screen.getmaxy).each do |y|
        if x == 0 or x == play_screen.map_screen.getmaxx - 1 or y == 0 or y == play_screen.map_screen.getmaxy - 1
          self.grid[x][y] = Tile.rock_wall
        else
          self.grid[x][y] = Tile.rand
        end
      end
    end
    play_screen.say("Done! Press an arrow key to start.")
  end

  def display_map
    #play_screen.map_screen.erase
    play_screen.map_screen.move(0,0)
    (0...play_screen.map_screen.getmaxy).each do |y|
      (0...play_screen.map_screen.getmaxx).each do |x|
        tile = grid[x][y]
        if tile.lit?
          icon = tile.feature.icon
          play_screen.map_screen.attrset icon.color
          play_screen.map_screen.addch icon.char
        else
          play_screen.map_screen.addch ?\s
        end
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
