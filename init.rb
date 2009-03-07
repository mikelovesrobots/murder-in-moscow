require 'ncurses'
require 'active_support'
require 'lib/mim'

DEBUG = true

if DEBUG
  require 'ruby-debug'
  Debugger.wait_connection = true
  Debugger.start_remote
end

Mim.new
