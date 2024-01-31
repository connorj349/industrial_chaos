extends Control

const max_stat = 20
const occupation_slot_prefab = preload("res://UI/OccupationSlot.tscn")

onready var occupation_holder = $PanelContainer/TabContainer/Occupations/ScrollContainer/VBoxContainer

var unallocated_points setget set_unallocated_points
var starting_stats = [1, 1, 0] setget set_starting_stats

enum Stat {
	Strength,
	Perception,
	Toughness
}

signal on_points_changed
signal on_stats_changed

func _ready():
# warning-ignore:return_value_discarded
	connect("on_points_changed", self, "update_ui")
# warning-ignore:return_value_discarded
	connect("on_stats_changed", self, "update_ui")
	self.unallocated_points = Gamestate.player_max_allocated_points_allowed
	populate_occupations_page()

func populate_occupations_page():
	if Gamestate.game_difficulty.allowed_occupations.size() > 0:
		for o in Gamestate.game_difficulty.allowed_occupations:
			var new_occupation_slot = occupation_slot_prefab.instance()
			occupation_holder.add_child(new_occupation_slot)
			new_occupation_slot.get_node("HBoxContainer/NameLabel").text = o.occupation_name
			new_occupation_slot.get_node("HBoxContainer/DescriptionLabel").text = o.occupation_description
			new_occupation_slot.get_node("HBoxContainer/ChooseButton").connect("pressed", self, "spawn_player_as_occupation", [o])

func spawn_player_as_occupation(occupation):
	starting_stats[0] = occupation.starting_strength
	starting_stats[1] = occupation.starting_perception
	starting_stats[2] = occupation.starting_toughness
	spawn_player()

func spawn_player():
	Gamestate.emit_signal("on_player_spawn", starting_stats)
	queue_free()

func set_unallocated_points(value):
	unallocated_points = clamp(value, 0, Gamestate.player_max_allocated_points_allowed)
	emit_signal("on_points_changed")

func set_starting_stats(value):
	starting_stats = value
	emit_signal("on_stats_changed")

func on_minus_stat(stat):
	if stat == Stat.Toughness:
		self.starting_stats[Stat.Toughness] = clamp(starting_stats[Stat.Toughness] - 1, 0, max_stat)
		self.unallocated_points += 1
		return
	if starting_stats[stat] <= 1:
		return
	match(stat):
		Stat.Strength:
			self.starting_stats[Stat.Strength] = clamp(starting_stats[Stat.Strength] - 1, 0, max_stat)
		Stat.Perception:
			self.starting_stats[Stat.Perception] = clamp(starting_stats[Stat.Perception] - 1, 0, max_stat)
	self.unallocated_points += 1

func on_add_stat(stat):
	if unallocated_points > 0:
		match(stat):
			Stat.Strength:
				self.starting_stats[Stat.Strength] = clamp(starting_stats[Stat.Strength] + 1, 0, max_stat)
			Stat.Perception:
				self.starting_stats[Stat.Perception] = clamp(starting_stats[Stat.Perception] + 1, 0, max_stat)
			Stat.Toughness:
				self.starting_stats[Stat.Toughness] = clamp(starting_stats[Stat.Toughness] + 1, 0, max_stat)
		self.unallocated_points -= 1

func update_ui():
	$PanelContainer/TabContainer/PlayerStats/RemainingPointsLabel.text = "Points Reamaining: " + str(unallocated_points)
	$PanelContainer/TabContainer/PlayerStats/StrengthStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(starting_stats[0])
	$PanelContainer/TabContainer/PlayerStats/PerceptionStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(starting_stats[1])
	$PanelContainer/TabContainer/PlayerStats/ToughnessStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(starting_stats[2])
