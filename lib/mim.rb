module Mim
  # initializes ncurses and yields up the current window.  Ensures 
  # in the case of errors that ncurses shuts down cleanly.
  #
  #   Mim.initialize_ncurses do |window|
  #     window.addstr "Murder in Moscow"
  #     window.refresh
  #     window.getch
  #   end
  #
  def self.initialize_ncurses
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

  def self.initialize_game(window)
    messages_window = window.subwin(4,max_columns(window),0,0) # h, w, y, x
    messages_window.bkgd Ncurses.COLOR_PAIR(2)
    messages_window.addstr "Hello, from the messages window."

    map_window = window.subwin(27,90,4,1)
    map_window.bkgd Ncurses.COLOR_PAIR(3)
    map_window.addstr "Hello from the map window"

    status_window = window.subwin(27, (max_columns(window) - 90 - 3), 4, 92)
    status_window.bkgd Ncurses.COLOR_PAIR(4)
    status_window.addstr "Hello from the status window"
    #window.addstr "Hello from the top window"
    window.refresh
    window.getch
  end

  def self.max_lines(window)
    lines = []
    columns = []
    window.getmaxyx(lines, columns)

    lines.first
  end

  def self.max_columns(window)
    lines = []
    columns = []
    window.getmaxyx(lines, columns)
    columns.first
  end
end

