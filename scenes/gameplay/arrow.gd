extends RigidBody2D

# TODO: Need to decide if something like this actually makes sense for the arrow
const BLAST_IMPULSE := 1500.0

var arrow_direction := Vector2.ZERO:
	set = set_arrow_direction

@onready var hit_box: Area2D = $HitBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


func _physics_process(delta):
	# Update the arrow's rotation based on its velocity
	if linear_velocity.length() > 0:
		rotation = linear_velocity.angle()


func _integrate_forces(state):
	state.apply_force(Vector2.from_angle(60))


func _on_body_entered(body: Node) -> void:
	hit(body)


func hit(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage()


func set_arrow_direction(new_arrow_direction: Vector2) -> void:
	arrow_direction = new_arrow_direction
	linear_velocity = BLAST_IMPULSE * arrow_direction
	rotation = arrow_direction.angle()
