extends Node

var player_max_allocated_points_allowed = 5
var player_lives = 5
var game_difficulty = preload("res://Data/game_difficulty/easy.tres")

# warning-ignore:unused_signal
signal on_player_spawn
# warning-ignore:unused_signal
signal on_player_death
