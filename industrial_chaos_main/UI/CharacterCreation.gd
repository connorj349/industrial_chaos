extends Control

var unallocated_points setget set_unallocated_points
var starting_stats = [1, 1, 0]

enum Stat {
	Strength,
	Perception,
	Toughness
}

signal on_points_changed

func _ready():
# warning-ignore:return_value_discarded
	connect("on_points_changed", self, "update_ui")
	unallocated_points = Gamestate.player_max_allocated_points_allowed
	# populate the classes page

func set_unallocated_points(value):
	unallocated_points = clamp(value, 0, Gamestate.player_max_allocated_points_allowed)
	emit_signal("on_points_changed", unallocated_points)

#func on_minus_stat(stat): # all minus buttons use this
	#match(stat):
		#Stat.Strength:
			#starting_stats[Stat.Strength] = clamp(starting_stats[Stat.Strength] - 1, 0, Gamestate.player_max_allocated_points_allowed)
			#unallocated_points -= 1

#func on_add_stat(stat): # all minus buttons use this
	#match(stat):
		#Stat.Strength:
			#starting_stats[Stat.Strength] = clamp(starting_stats[Stat.Strength] + 1, 0, Gamestate.player_max_allocated_points_allowed)
			#unallocated_points += 1

func update_ui():
	$PanelContainer/TabContainer/PlayerStats/RemainingPointsLabel.text = str(unallocated_points)
	$PanelContainer/TabContainer/PlayerStats/StrengthStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(starting_stats[0])
	$PanelContainer/TabContainer/PlayerStats/PerceptionStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(starting_stats[1])
	$PanelContainer/TabContainer/PlayerStats/ToughnessStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(starting_stats[2])
