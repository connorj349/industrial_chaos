extends Interactable

const max_time = 3.0

onready var work_timer = $WorkTimer
onready var work_progressbar = $CanvasLayer/Control/PanelContainer/VBoxContainer/WorkProgressBar

func _process(_delta):
	if work_timer.time_left > 0:
		work_progressbar.value = work_timer.time_left

func start_work():
	if (Globals.current_player.stats.fatigue + 3) < 10:
		work_timer.start()

func view_machine(_actor):
	var reduced_time = max_time * float(_actor.stats.strength / 20.0)
	work_timer.wait_time = max_time - reduced_time
	work_progressbar.max_value = work_timer.wait_time
	$CanvasLayer/Control.set_visible(true)
	Globals.emit_signal("toggle_cursor", true)

func stop_viewing_machine():
	work_timer.stop()
	$CanvasLayer/Control.set_visible(false)
	Globals.emit_signal("toggle_cursor", false)

func _on_WorkTimer_timeout():
	Globals.current_player.stats.fatigue += 3
