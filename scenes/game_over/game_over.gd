extends Control

@onready var retry_button = $MarginContainer/Control/VBoxContainer2/VBoxContainer/RetryButton
@onready
var game_over_message: Label = $MarginContainer/Control/VBoxContainer2/CenterContainer2/Title


func pre_start(params):
	var cur_scene: Node = get_tree().current_scene
	print("Scene loaded: ", cur_scene.name, " (", cur_scene.scene_file_path, ")")
	if params:
		var message = params["message"]
		if message != null:
			game_over_message.text = message


func _ready():
	# needed for gamepads to work
	retry_button.grab_focus()


func _on_retry_button_pressed():
	var params = {
		"show_progress_bar": true,
		"start_scene": GameState.scene_progress,
	}
	Game.change_scene_to_file("res://scenes/gameplay/gameplay.tscn", params)
