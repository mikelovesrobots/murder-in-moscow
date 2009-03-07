$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'mim_screen/dimensions'
require 'mim_screen/text_formatting'
require 'mim_screen'

require 'screens/menu_screen'

class Mim
  def initialize
    ncurses do |window|
      MenuScreen.new window
    end
  end

  private

  # initializes ncurses and yields up the current window.  Ensures 
  # in the case of errors that ncurses shuts down cleanly.
  #
  #   Mim.new 
  #     ncurses do |window|
  #       MenuScreen.new window
  #     end
  #   end
  #
  def ncurses
    begin
      window = Ncurses.initscr
      Ncurses.cbreak
      
      Ncurses.start_color
      Ncurses.init_pair 1, Ncurses::COLOR_WHITE, Ncurses::COLOR_BLACK
      Ncurses.init_pair 2, Ncurses::COLOR_YELLOW, Ncurses::COLOR_BLACK
      Ncurses.init_pair 3, Ncurses::COLOR_YELLOW, Ncurses::COLOR_BLUE
      Ncurses.init_pair 4, Ncurses::COLOR_YELLOW, Ncurses::COLOR_GREEN
     
      yield window
    ensure
      Ncurses.endwin
    end
  end
end

