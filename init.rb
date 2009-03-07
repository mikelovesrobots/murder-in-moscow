require 'ncurses'
require 'lib/mim'

Mim.initialize_ncurses do |window|
  "Murder in Moscow".each_byte do |ch|
    window.addch ch
    window.refresh
    Ncurses.napms 100 # refreshes every 1/10th of a second
  end
  window.getch
end

