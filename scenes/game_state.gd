extends Node

enum STATE { RUNNING, PLAYER_DEAD, NPCS_DEAD, FAILED, COMPLETED }

@export var scene_progress = "start"
@export var current_state: STATE = STATE.RUNNING

var torben_dead = false
var edda_dead = false
var player_dead = false


func reset():
	current_state = STATE.RUNNING
	scene_progress = "start"
	torben_dead = false
	edda_dead = false
	player_dead = false


func is_running() -> bool:
	return current_state == STATE.RUNNING
	
func on_completed() -> void:
	current_state = STATE.COMPLETED
