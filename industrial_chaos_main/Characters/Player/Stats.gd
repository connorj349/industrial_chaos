extends Spatial

# max total value of all core stats
var max_stats = 20 setget, get_max_stats

# core stats
var strength = 1 setget set_strength, get_strength
var perception = 1 setget set_perception, get_perception
var toughness = 0

# secondary stats
var hunger = 0 setget set_hunger
var filter = 0 setget set_filter
var fatigue = 0 setget set_fatigue

signal on_core_stats_changed
signal on_filter_changed
signal on_fatigue_changed
signal on_hunger_changed

func init(_strength, _perception, _toughness):
	self.strength = _strength
	self.perception = _perception
	self.toughness = _toughness
	self.filter = 5
	self.hunger = 0
	self.fatigue = 0

func set_strength(value):
	strength = clamp(value, 0, max_stats)
	emit_signal("on_core_stats_changed", [self.strength, self.perception, self.toughness])

func get_strength():
	if filter <= 0:
		return clamp((strength - 1) - (fatigue / 4), 0, max_stats)
	return clamp(strength - (fatigue / 4), 0, max_stats)

func set_perception(value):
	perception = clamp(value, 0, max_stats)
	emit_signal("on_core_stats_changed", [self.strength, self.perception, self.toughness])

func get_perception():
	if fatigue >= 5:
		return clamp(perception - round(fatigue / 2), 0, max_stats)
	return clamp(perception, 0, max_stats)

func set_toughness(value):
	toughness = clamp(value, 0, max_stats)
	emit_signal("on_core_stats_changed", [self.strength, self.perception, self.toughness])

func get_toughness():
	return clamp(toughness, 0, max_stats) # + worn_armor.armor_value

func get_max_stats():
	return clamp(max_stats - (self.strength + self.perception + self.toughness), 0, 20)

func set_filter(value):
	filter = clamp(value, 0 , 10)
	emit_signal("on_filter_changed", filter)

func set_hunger(value):
	hunger = clamp(value, 0, 10)
	emit_signal("on_hunger_changed", hunger)

func set_fatigue(value):
	fatigue = clamp(value, 0, 10)
	emit_signal("on_fatigue_changed", fatigue)
