class PlayScreen < MimScreen::Base
  attr_accessor :messages_screen, :map_screen, :status_screen

  def after_render_screen
    screen.erase

    [:messages_screen, :map_screen, :status_screen].each do |attr|
      dim = send("#{attr}_dimensions")

      send("#{attr}=", returning(screen.subwin(dim[:lines], dim[:cols], dim[:y], dim[:x])) do |sub_screen|
        sub_screen.border(0,0,0,0,0,0,0,0)
      end)
    end

    messages_screen.scrollok(true)
    screen.keypad(true)
    screen.refresh
  end

  def before_destroy_screen
    map_screen.delwin
    status_screen.delwin
    messages_screen.delwin
  end

  def main_loop(screen)
    # wait for a keystroke
    loop do
      messages_screen.refresh
      case key = screen.getch 
      when Ncurses::KEY_DOWN
        messages_screen.addstr("down\n")
      when Ncurses::KEY_UP
        messages_screen.addstr("up\n")
      when Ncurses::KEY_RIGHT
        messages_screen.addstr("right\n")
      when Ncurses::KEY_LEFT
        messages_screen.addstr("left\n")
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
