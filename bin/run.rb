require_relative '../config/environment'
require 'tty-prompt'

system "clear"  # clears screen
app = ReservationApp.new
app.runner
