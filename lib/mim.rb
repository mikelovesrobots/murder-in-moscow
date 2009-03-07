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

      yield window
    ensure
      Ncurses.endwin
    end
  end
end

