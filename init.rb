require 'ncurses'
require 'active_support'
require 'lib/mim'

DEBUG = false

if DEBUG
  require 'ruby-debug'
  Debugger.wait_connection = true
  Debugger.start_remote
end

Mim.new
