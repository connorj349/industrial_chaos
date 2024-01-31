extends Node

const character_creation = preload("res://UI/CharacterCreation.tscn")

var player_max_allocated_points_allowed = 5
var player_lives = 5
var game_difficulty = preload("res://Data/game_difficulty/easy.tres")

# warning-ignore:unused_signal
signal on_player_spawn
# warning-ignore:unused_signal
signal on_player_death

func _ready():
# warning-ignore:return_value_discarded
	connect("on_player_death", self, "reset_player_gamestate")

func reset_player_gamestate():
	player_lives -= 1
	if player_lives <= 0:
		# gameover logic
		pass
	var new_character_creation = character_creation.instance()
	get_tree().get_root().add_child(new_character_creation)
