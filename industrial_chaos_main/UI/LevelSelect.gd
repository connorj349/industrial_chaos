extends Control

enum DifficultyLevels {
	Easy, # 0
	Medium, # 1
	Hard, # 2
	Chaos # 3
}

signal on_level_select

func on_difficulty_changed(difficulty):
	match difficulty:
		DifficultyLevels.Easy:
			Gamestate.game_difficulty = load("res://Data/game_difficulty/easy.tres")
			$PanelContainer/VBoxContainer/PointsAllowedLabel2.hide()
			$PanelContainer/VBoxContainer/CurrentDifficultySelectedLabel.text = "Difficulty: Easy"
		DifficultyLevels.Medium:
			Gamestate.game_difficulty = load("res://Data/game_difficulty/medium.tres")
			$PanelContainer/VBoxContainer/PointsAllowedLabel2.hide()
			$PanelContainer/VBoxContainer/CurrentDifficultySelectedLabel.text = "Difficulty: Medium"
		DifficultyLevels.Hard:
			Gamestate.game_difficulty = load("res://Data/game_difficulty/hard.tres")
			$PanelContainer/VBoxContainer/PointsAllowedLabel2.hide()
			$PanelContainer/VBoxContainer/CurrentDifficultySelectedLabel.text = "Difficulty: Hard"
		DifficultyLevels.Chaos:
			Gamestate.game_difficulty = load("res://Data/game_difficulty/chaos.tres")
			$PanelContainer/VBoxContainer/PointsAllowedLabel2.show()
			$PanelContainer/VBoxContainer/CurrentDifficultySelectedLabel.text = "Difficulty: Chaos"
	
	$PanelContainer/VBoxContainer/PointsAllowedLabel.text = "Stat Allocation Points: " + str(Gamestate.game_difficulty.allowed_allocated_points)
	$PanelContainer/VBoxContainer/LivesAllowedLabel.text = "Player Lives: " + str(Gamestate.game_difficulty.lives_allowed)
	Gamestate.player_max_allocated_points_allowed = Gamestate.game_difficulty.allowed_allocated_points
	Gamestate.player_lives = Gamestate.game_difficulty.lives_allowed

func on_level_select(path):
	emit_signal("on_level_select", path)
