extends Control

signal on_level_select

func on_difficulty_changed(points_allowed, difficulty_name):
	Gamestate.player_max_allocated_points_allowed = points_allowed
	$PanelContainer/VBoxContainer/CurrentDifficultySelectedLabel.text = difficulty_name
	$PanelContainer/VBoxContainer/PointsAllowedLabel.text = "Stat Allocation Points: " + str(points_allowed)
	if difficulty_name == "Chaos":
		$PanelContainer/VBoxContainer/PointsAllowedLabel2.show()
	else:
		$PanelContainer/VBoxContainer/PointsAllowedLabel2.hide()

func on_level_select(path):
	emit_signal("on_level_select", path)
