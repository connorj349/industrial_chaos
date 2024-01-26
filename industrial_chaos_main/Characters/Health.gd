extends Spatial

export(int) var max_health = 1 setget set_max_health, get_max_health

var health = 1 setget set_health

signal dead
signal health_changed

func init():
	self.health = max_health

func set_max_health(value):
	max_health = value
	if health > value:
		health = max_health

func get_max_health():
	return max_health # - polluted_val # this is the value that is gained when player doesn't have air filters

func set_health(val):
	health = clamp(val, 0, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("dead")
