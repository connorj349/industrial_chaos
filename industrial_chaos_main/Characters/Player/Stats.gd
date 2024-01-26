extends Spatial

# max total value of all core stats
const max_stats = 20

# core stats
var strength setget set_strength, get_strength
var perception setget set_perception, get_perception
var toughness

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
	strength = clamp(value, 0, max_stats - (self.perception + self.toughness))
	emit_signal("on_core_stats_changed", strength, perception, toughness)

func get_strength():
	return strength - hunger

func set_perception(value):
	perception = clamp(value, 0, max_stats - (self.strength + self.toughness))
	emit_signal("on_core_stats_changed", strength, perception, toughness)

func get_perception():
	return perception - fatigue

func set_toughness(value):
	toughness = clamp(value, 0, max_stats - (self.strength + self.perception))
	emit_signal("on_core_stats_changed", strength, perception, toughness)

func get_toughness():
	return toughness # + worn_armor.armor_value
