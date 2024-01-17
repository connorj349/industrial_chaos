extends Node

func _ready():
	pass
	#setup databases here

func setup_database(file_path : String):
	var database = {}
	var file = File.new()
	file.open(file_path, File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	database = json.result
	return database
