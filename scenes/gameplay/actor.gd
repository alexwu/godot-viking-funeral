class_name Actor extends CharacterBody2D

enum STATE { IDLE, DEAD }

@export var dialogue_name: String = name
@export var current_state: STATE = STATE.IDLE

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box: Area2D = $HitBox


func hit() -> void:
	match current_state:
		STATE.DEAD:
			print(name + " is already dead.")
			return
		_:
			print(name + " has been killed.")
			match name:
				"Edda":
					GameState.edda_dead = true
				"Torben":
					GameState.torben_dead = true
				_:
					print("Killing unknown actor: " + name)
			_enter_state(STATE.DEAD)


func _ready() -> void:
	_enter_state(STATE.IDLE)


func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta

	move_and_collide(velocity * delta)


func _enter_state(new_state: STATE):
	current_state = new_state
	match current_state:
		STATE.IDLE:
			animation_player.play("idle")
		STATE.DEAD:
			animation_player.stop()


func _on_hit_box_body_entered(body: Node2D) -> void:
	print("Actor hit box hit: " + name)
	print("Actor hit box hit by: " + body.name)
	if body.name == "Arrow":
		hit()
