class_name Boat extends CharacterBody2D

signal target_hit

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = move_toward(velocity.x, 50, SPEED)

	move_and_slide()
	


func _on_hit_box_body_entered(body: Node2D) -> void:
	target_hit.emit()
