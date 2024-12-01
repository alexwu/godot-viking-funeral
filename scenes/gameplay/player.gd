extends CharacterBody2D

enum STATE { IDLE, AIMING, DEAD }

@export var time_step = 0.1
@export var max_steps = 100
@export var max_power = 2000.0
@export var move_speed = 300.0
@export var jump_velocity = -400.0
@export var arrow_spawn_distance = 50.0  # Distance from the player to spawn the arrow

var current_state = STATE.IDLE
var _aim_direction = Vector2(1, 0)
var _power = 100.0

@onready var arrow_scene = preload("res://scenes/gameplay/arrow.tscn")
@onready var arrow_spawn_position: Area2D = $Area2D
@onready var trajectory_line = $Line2D


func hit() -> void:
	match current_state:
		STATE.DEAD:
			print(name + " is already dead.")
			return
		_:
			_enter_state(STATE.DEAD)


func _enter_state(new_state: STATE):
	current_state = new_state
	match current_state:
		STATE.IDLE:
			stop_aiming()
		STATE.AIMING:
			start_aiming()
		STATE.DEAD:
			GameState.player_dead = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()


func is_aiming():
	return current_state == STATE.AIMING


func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("aim"):
		if !is_aiming():
			_enter_state(STATE.AIMING)
	elif Input.is_action_just_released("aim"):
		_enter_state(STATE.IDLE)

	if is_aiming():
		update_aiming(delta)
		if Input.is_action_just_pressed("shoot"):
			shoot_arrow()

	update_trajectory_line()


func start_aiming():
	current_state = STATE.AIMING
	_power = 0.0
	trajectory_line.visible = true


func stop_aiming():
	current_state = STATE.IDLE
	trajectory_line.visible = false


func update_aiming(delta):
	# Update aim direction based on mouse position
	var mouse_position = get_global_mouse_position()
	_aim_direction = (mouse_position - global_position).normalized()

	# Calculate the angle and new spawn position
	var angle = _aim_direction.angle()
	var new_spawn_position = Vector2(
		arrow_spawn_distance * cos(angle), arrow_spawn_distance * sin(angle)
	)

	# Set the new spawn position relative to the player's position
	arrow_spawn_position.global_position = global_position + new_spawn_position
	# Increase _power based on the time the button is held
	_power = min(_power + delta * 5000, max_power)


func shoot_arrow():
	var arrow_instance = arrow_scene.instantiate()
	arrow_instance.global_position = arrow_spawn_position.global_position
	arrow_instance.linear_velocity = _aim_direction * _power
	get_tree().root.add_child(arrow_instance)
	stop_aiming()


func update_trajectory_line():
	var points = []
	var trajectory_position = arrow_spawn_position.position
	var projected_velocity = _aim_direction * _power

	trajectory_line.points.clear()

	for step in range(max_steps):
		points.append(trajectory_position)
		projected_velocity += get_gravity() * time_step
		trajectory_position += projected_velocity * time_step
		if trajectory_position.y > 1000:  # Stop if the arrow goes too high
			break

	trajectory_line.points = points
