extends Node

var current_player #allows other objects to reference the player like setting target/etc.
var current_ui #set global ui to this so anything can access ui methods

# warning-ignore:unused_signal
signal toggle_cursor
# warning-ignore:unused_signal
signal on_gui_toggle
