module MimScreen
  class Base
    include MimScreen::Dimensions
    include MimScreen::TextFormatting

    attr_reader :screen

    def initialize(parent_window)
      before_render_screen
      @screen = render_screen(parent_window)
      after_render_screen

      parent_window.refresh
      main_loop(screen)
      screen.delwin
    end

    # Override for fun and profit
    def before_render_screen
    end

    # Renders this screen inside the parent_window.
    def render_screen(parent_window)
      returning(parent_window.subwin(Ncurses.LINES, Ncurses.COLS, 0, 0)) do |screen|
        screen.border(0,0,0,0,0,0,0,0)
      end
    end

    # Override for fun and profit
    def after_render_screen
    end

    # Responsible for doing whatever this screen is supposed to do 
    # once it's up (e.g., manage inventory, battle monsters, etc.)
    def main_loop(screen)
    end
  end
end


