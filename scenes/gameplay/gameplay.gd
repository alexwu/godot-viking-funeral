extends Node

@export var background_music: AudioStream

@onready var boat: Boat = $Boat

var dialogue = load("res://dialogue/start.dialogue")
var elapsed = 0


# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	var cur_scene: Node = get_tree().current_scene
	print("Scene loaded: ", cur_scene.name, " (", cur_scene.scene_file_path, ")")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)
	GameState.reset()
	boat.target_hit.connect(GameState.on_completed)

	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.passed_title.connect(_on_title_passed)
	DialogueManager.got_dialogue.connect(_on_dialogue)

	if background_music:
		SoundManager.play_music(background_music)


# `start()` is called after pre_start and after the graphic transition ends.
func start():
	print("gameplay.gd: start() called")
	DialogueManager.show_dialogue_balloon(dialogue, "i_am_ivar")


func _process(_delta):
	match GameState.current_state:
		GameState.STATE.RUNNING:
			pass
		GameState.STATE.COMPLETED:
			Game.change_scene_to_file(
				"res://scenes/you_win/you_win.tscn", {"show_progress_bar": false}
			)
		GameState.STATE.PLAYER_DEAD:
			Game.change_scene_to_file(
				"res://scenes/game_over/game_over.tscn",
				{
					"show_progress_bar": false,
					"message": "Well Ivar, you hit yourself with your own arrow and died."
				}
			)
		GameState.STATE.EDDA_DEAD:
			Game.change_scene_to_file(
				"res://scenes/game_over/game_over.tscn",
				{
					"show_progress_bar": false,
					"message":
					"You hit Edda with your arrow. She’s still alive, but extremely pissed."
				}
			)
		_:
			Game.change_scene_to_file(
				"res://scenes/game_over/game_over.tscn", {"show_progress_bar": false}
			)


func _on_dialogue_ended(_resource):
	pass


func _on_title_passed(title):
	pass


func _on_dialogue(next_dialogue):
	pass
