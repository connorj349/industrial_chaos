extends Spatial

# max total value of all core stats
var max_stats = 20 setget, get_max_stats
var upgrade_points = 0 setget set_upgrade_points

# core stats
var strength = 1 setget set_strength, get_strength
var perception = 1 setget set_perception, get_perception
var toughness = 0 setget set_toughness, get_toughness

# secondary stats
var hunger = 0 setget set_hunger
var filter = 5 setget set_filter
var fatigue = 0 setget set_fatigue

signal on_core_stats_changed
signal on_upgrade_points_changed
signal on_filter_changed
signal on_fatigue_changed
signal on_hunger_changed

func _process(_delta):
	if Input.is_action_just_pressed("open_stats"):
		$CanvasLayer/Control.set_visible(!$CanvasLayer/Control.visible)
		Globals.emit_signal("toggle_cursor", $CanvasLayer/Control.visible)

func init(_strength, _perception, _toughness):
	self.strength = _strength
	self.perception = _perception
	self.toughness = _toughness
	self.hunger = 0
	self.filter = 5
	self.fatigue = 0

func update_stats_menu(_current_stats):
	$CanvasLayer/Control/PanelContainer/VBoxContainer/StrengthStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(self.strength)
	$CanvasLayer/Control/PanelContainer/VBoxContainer/PerceptionStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(self.perception)
	$CanvasLayer/Control/PanelContainer/VBoxContainer/ToughnessStat/VBoxContainer/HBoxContainer/CurrAmountLabel.text = str(self.toughness)

func update_points_count():
	$CanvasLayer/Control/PanelContainer/VBoxContainer/RemainingPointsLabel.text = "Points remaining: " + str(upgrade_points)

func upgrade_stat(stat):
	if upgrade_points > 0:
		match stat:
			0:
				self.strength += 1
			1:
				self.perception += 1
			2:
				self.toughness += 1
		self.upgrade_points -= 1

func set_strength(value):
	strength = clamp(value, 0, max_stats)
	emit_signal("on_core_stats_changed", [self.strength, self.perception, self.toughness])

func get_strength():
	if filter <= 0:
		return clamp((strength - 1) - (hunger / 4), 0, max_stats)
	return clamp(strength - (hunger / 4), 0, max_stats)

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

func set_upgrade_points(value):
	upgrade_points = clamp(value, 0, 999)
	emit_signal("on_upgrade_points_changed")

func _on_FilterTimer_timeout():
	self.filter -= 1
