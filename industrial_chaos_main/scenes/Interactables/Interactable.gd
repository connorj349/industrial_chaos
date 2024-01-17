extends Spatial
class_name Interactable

var can_interact = true

func _ready():
	if !is_in_group("interactable"):
		add_to_group("interactable")
	if (get_child(0).get_active_material(0).next_pass != null): #sets the nextpass glow off if it has a nextpass
		var mat = get_child(0).get_active_material(0)
		get_child(0).set_surface_material(0, mat.duplicate(true))
		get_child(0).get_active_material(0).next_pass.params_grow = false

func toggle_select(toggle): #toggles the glow on next_pass material(only if the object has one)
	if (get_child(0).get_active_material(0).next_pass != null):
		if toggle and can_interact:
			get_child(0).get_active_material(0).next_pass.params_grow = true
			get_child(0).get_active_material(0).next_pass.params_grow_amount = 0.01
			pass
		else:
			get_child(0).get_active_material(0).next_pass.params_grow = false

func _interact(_actor): #overridable method
	pass
