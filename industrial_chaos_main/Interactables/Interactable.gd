extends Spatial
class_name Interactable

var can_interact = true

signal on_interact

func _ready():
	if !is_in_group("interactable"):
		add_to_group("interactable")

func _interact(_actor): #overridable method
	if can_interact:
		emit_signal("on_interact", _actor)
