extends Control

@onready var retry_button = $MarginContainer/Control/VBoxContainer2/VBoxContainer/RetryButton


func _on_retry_button_pressed():
	var params = {
		"show_progress_bar": true,
		"a_number": 10,
		"a_string": "Ciao!",
		"an_array": [1, 2, 3, 4],
		"a_dict": {"name": "test", "val": 15},
	}
	Game.change_scene_to_file("res://scenes/gameplay/gameplay.tscn", params)
