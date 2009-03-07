require 'ncurses'
require 'lib/mim'

Mim.initialize_ncurses do |window|
  Mim.initialize_game(window)
end

