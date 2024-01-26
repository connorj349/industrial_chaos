extends Spatial

# max total value of all core stats
var max_stats = 20 setget, get_max_stats

# core stats
var strength = 1 setget set_strength, get_strength
var perception = 1 setget set_perception, get_perception
var toughness = 0

# secondary stats
var hunger = 0
var filter = 0
var fatigue = 0

signal on_core_stats_changed

func init(_strength, _perception, _toughness):
	self.strength = _strength
	self.perception = _perception
	self.toughness = _toughness

func set_strength(value):
	strength = clamp(value, 0, max_stats)
	emit_signal("on_core_stats_changed", strength, perception, toughness)

func get_strength():
	if filter <= 0:
		return clamp((strength - 1) - (fatigue / 4), 0, max_stats)
	return clamp(strength - (fatigue / 4), 0, max_stats)

func set_perception(value):
	perception = clamp(value, 0, max_stats)
	emit_signal("on_core_stats_changed", strength, perception, toughness)

func get_perception():
	if fatigue >= 5:
		return clamp(perception - round(fatigue / 2), 0, max_stats)
	return clamp(perception, 0, max_stats)

func set_toughness(value):
	toughness = clamp(value, 0, max_stats)
	emit_signal("on_core_stats_changed", strength, perception, toughness)

func get_toughness():
	return clamp(toughness, 0, max_stats) # + worn_armor.armor_value

func get_max_stats():
	return clamp(max_stats - (self.strength + self.perception + self.toughness), 0, 20)
