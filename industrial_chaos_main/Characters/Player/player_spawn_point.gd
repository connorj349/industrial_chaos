extends Spatial

const player_prefab = preload("res://Characters/Player/Player.tscn")

func _ready():
# warning-ignore:return_value_discarded
	Gamestate.connect("on_player_spawn", self, "spawn_player")

func spawn_player(starting_stats):
	var new_player = player_prefab.instance()
	get_tree().get_root().add_child(new_player)
	new_player.global_transform = global_transform
	new_player.init_stats(starting_stats)
