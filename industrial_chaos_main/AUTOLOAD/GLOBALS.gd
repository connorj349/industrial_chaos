extends Node

var current_player #allows other objects to reference the player like setting target/etc.
var current_ui #set to current active ui so that other methods can access things on the ui

# warning-ignore:unused_signal
signal toggle_cursor
# warning-ignore:unused_signal
signal on_gui_toggle

func _process(_delta):
	#debug close out
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
