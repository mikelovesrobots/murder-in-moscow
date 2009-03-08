class PlayScreen < MimScreen::Base
  attr_accessor :messages_screen, :map_screen, :status_screen
  attr_accessor :messages_border_screen, :map_border_screen, :status_border_screen

  def after_render_screen
    screen.erase

    self.messages_border_screen = create_border_screen(messages_screen_dimensions)
    self.messages_screen = create_sub_screen(messages_border_screen, messages_screen_dimensions)
    
    self.map_border_screen = create_border_screen(map_screen_dimensions)
    self.map_screen = create_sub_screen(map_border_screen, map_screen_dimensions)
    
    self.status_border_screen = create_border_screen(status_screen_dimensions)
    self.status_screen = create_sub_screen(status_border_screen, status_screen_dimensions)

    messages_screen.scrollok(true)
    screen.keypad(true)
    screen.refresh
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

  def main_loop(screen)
    # wait for a keystroke
    loop do
      messages_screen.refresh
      case key = screen.getch 
      when Ncurses::KEY_DOWN
        messages_screen.addstr("\ndown")
      when Ncurses::KEY_UP
        messages_screen.addstr("\nup")
      when Ncurses::KEY_RIGHT
        messages_screen.addstr("\nright")
      when Ncurses::KEY_LEFT
        messages_screen.addstr("\nleft")
      else 
        # we're done, exit
        break
      end
    end
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
