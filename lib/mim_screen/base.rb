module MimScreen
  class Base
    def initialize(parent_window)
      screen = render_window(parent_window)
      main_loop(screen)
      screen.delwin
    end

    # Renders this screen inside the parent_window.  Override for
    # fun and buckets.
    def render_window(parent_window)
      returning(parent_window.subwin(Ncurses.LINES, Ncurses.COLS, 0, 0)) do |screen|
        screen.border(0,0,0,0,0,0,0,0)
        parent_window.refresh
      end
    end

    # Responsible for doing whatever this screen is supposed to do 
    # once it's up (e.g., manage inventory, battle monsters, etc.)
    def main_loop(screen)
    end
  end
end


