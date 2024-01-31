extends KinematicBody

export var mouse_sensitivity = 0.1

onready var head = $Head
onready var camera = $Head/Camera
onready var interact_area = $Head/Camera/InteractArea
onready var movement = $Movement
onready var health = $Health
onready var stats = $Stats

var cam_accel = 40

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	movement.init(self)
	health.init()
	#health.connect("health_changed", something, "play_hurt_effects")
# warning-ignore:return_value_discarded
	Globals.connect("toggle_cursor", self, "_toggle_cursor")
	Globals.current_player = self

func take_damage(amount):
	var reduced_damage = amount * (float(stats.toughness) / 20.0)
	health.health -= round(amount - reduced_damage)

func init_stats(starting_stats):
	stats.init(starting_stats[0], starting_stats[1], starting_stats[2])

func on_death():
	Gamestate.emit_signal("on_player_death")
	Globals.emit_signal("toggle_cursor", true)
	queue_free()

# change this to a healthbar
func update_health_text(current_health):
	$CanvasLayer/UI/VBoxContainer/HealthLabel.text = "HEALTH: " + str(current_health)

# change to bar
func update_filter_text(remaining_filter):
	$CanvasLayer/UI/VBoxContainer/FilterLabel.text = "FILTER: " + str(remaining_filter)

# change to bar
func update_fatigue_text(current_fatigue):
	$CanvasLayer/UI/VBoxContainer/FatigueLabel.text = "FATIGUE: " + str(current_fatigue)

# change to bar
func update_hunger_text(current_hunger):
	$CanvasLayer/UI/VBoxContainer/HungerLabel.text = "HUNGER: " + str(current_hunger)

func _input(event):
	if !player_is_in_menu():
		if event is InputEventMouseMotion:
			rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
			head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
			head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _process(delta):
	if !player_is_in_menu():
		#interacting
		if Input.is_action_just_pressed("interact"):
			if interact_area.monitoring:
				for body in interact_area.get_overlapping_bodies():
					if body.is_in_group("interactable"):
						body._interact(self)
		#jumping
		if Input.is_action_just_pressed("jump") and is_on_floor():
				movement.jump()
		#movement
		var direction = Vector3.ZERO
		var f_input = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
		var h_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		direction = Vector3(h_input, 0, f_input)
		movement.set_move_vector(direction)
	else:
		movement.set_move_vector(Vector3.ZERO)
	camera_physics_interpolation(delta)

func _toggle_cursor(toggle):
	if toggle:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func player_is_in_menu():
	match[Input.get_mouse_mode()]:
		[Input.MOUSE_MODE_CONFINED]:
			return true
		[Input.MOUSE_MODE_CAPTURED]:
			return false

func camera_physics_interpolation(delta): #followed tutorial for this
	if Engine.get_frames_per_second() > Engine.iterations_per_second:
		camera.set_as_toplevel(true)
		camera.global_transform.origin = camera.global_transform.origin.linear_interpolate(head.global_transform.origin, cam_accel * delta)
		camera.rotation.y = rotation.y
		camera.rotation.x = head.rotation.x
	else:
		camera.set_as_toplevel(false)
		camera.global_transform = head.global_transform
