class PlayScreen < MimScreen::Base
  attr_accessor :level

  ##
  ## Keyboard input
  ##

  def main_loop(screen)
    # wait for a keystroke
    loop do
      messages_screen.refresh
      case key = screen.getch 
      when Ncurses::KEY_DOWN
        move_player(:south)
      when Ncurses::KEY_UP
        move_player(:north)
      when Ncurses::KEY_RIGHT
        move_player(:east)
      when Ncurses::KEY_LEFT
        move_player(:west)
      else 
        # we're done, exit
        break
      end
    end
  end

  def move_player(direction)
    case direction
    when :south
      @player_y += 1 unless @player_y >= map_screen.getmaxy - 1 or level.blocked?(@player_x, @player_y + 1)
    when :north
      @player_y -= 1 unless @player_y <= 0 or level.blocked?(@player_x, @player_y - 1)
    when :west
      @player_x -= 1 unless @player_x <= 0 or level.blocked?(@player_x - 1, @player_y)
    when :east
      @player_x += 1 unless @player_x >= map_screen.getmaxx - 1 or level.blocked?(@player_x + 1, @player_y)
    end

    level.display_map
    #map_screen.erase

    map_screen.attrset(Ncurses.COLOR_PAIR(1))
    map_screen.mvaddch(@player_y, @player_x, ?@)
    map_screen.refresh

    say "Player moved #{direction} (#{@player_x}, #{@player_y})"
  end

  ##
  ## Screen setup
  ##

  attr_accessor :messages_screen, :map_screen, :status_screen
  attr_accessor :messages_border_screen, :map_border_screen, :status_border_screen

  def after_render_screen
    screen.erase

    # setup subscreens
    self.messages_border_screen = create_border_screen(messages_screen_dimensions)
    self.messages_screen = create_sub_screen(messages_border_screen, messages_screen_dimensions)
    
    self.map_border_screen = create_border_screen(map_screen_dimensions)
    self.map_screen = create_sub_screen(map_border_screen, map_screen_dimensions)
    
    self.status_border_screen = create_border_screen(status_screen_dimensions)
    self.status_screen = create_sub_screen(status_border_screen, status_screen_dimensions)

    messages_screen.scrollok(true)
    messages_screen.addstr("Initializing Game")
    messages_screen.refresh

    screen.keypad(true)
    screen.refresh

    @player_x = map_screen.getmaxx/2
    @player_y = map_screen.getmaxy/2
    
    self.level = Level.new(self)
  end

  def say(message)
    messages_screen.addstr("\n#{message}")
    messages_screen.refresh
  end

  def create_sub_screen(window, dimensions)
    window.subwin(dimensions[:lines]-2, dimensions[:cols]-2, dimensions[:y]+1, dimensions[:x]+1)
  end

  def create_border_screen(dimensions)
    returning(screen.subwin(dimensions[:lines], dimensions[:cols], dimensions[:y], dimensions[:x])) do |sub_screen|
      sub_screen.box(0,0)
    end
  end

  def before_destroy_screen
    [map_screen, map_border_screen, status_screen, status_border_screen, messages_screen, messages_border_screen].each(&:delwin)
  end

  private

  def messages_screen_dimensions
    {
      :lines => 6,
      :cols => Ncurses.COLS,
      :x => 0,
      :y => 0,
    }
  end

  def map_screen_dimensions
    {
      :lines => Ncurses.LINES - messages_screen_dimensions[:lines],
      :cols => Ncurses.COLS * 3 / 4,
      :x => 0,
      :y => messages_screen_dimensions[:lines]
    }
  end
  
  def status_screen_dimensions
    returning(map_screen_dimensions.dup) do |dimensions|
      dimensions[:x] = dimensions[:cols]
      dimensions[:cols] = Ncurses.COLS - dimensions[:cols]
    end
  end
end
