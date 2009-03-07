class PlayScreen < MimScreen::Base
  attr_accessor :messages_screen, :map_screen, :status_screen

  def after_render_screen
    screen.erase

    [:messages_screen, :map_screen, :status_screen].each do |attr|
      dim = send("#{attr}_dimensions")

      #debugger
      send("#{attr}=", returning(screen.subwin(dim[:lines], dim[:cols], dim[:y], dim[:x])) do |sub_screen|
        sub_screen.border(0,0,0,0,0,0,0,0)
      end)
    end
  end

  def before_destroy_screen
    map_screen.delwin
    status_screen.delwin
    messages_screen.delwin
  end

  def main_loop(screen)
    # wait for a keystroke
    screen.getch 
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
