extends Control

@onready var retry_button = $MarginContainer/Control/VBoxContainer2/VBoxContainer/RetryButton


func _ready():
	# needed for gamepads to work
	retry_button.grab_focus()


func _on_retry_button_pressed():
	var params = {
		"show_progress_bar": true,
		"start_scene": GameState.scene_progress,
	}
	Game.change_scene_to_file("res://scenes/gameplay/gameplay.tscn", params)
